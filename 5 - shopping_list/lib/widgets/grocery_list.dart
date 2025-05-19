import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/grocery_list_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() {
    return _GroceryListState();
  }
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https(
      'shopping-list-ebc83-default-rtdb.firebaseio.com',
      'shopping-list.json',
    );

    final response = await http.get(url);

    if (response.statusCode != 200 && response.statusCode != 201) {
      setState(() {
        _error = 'We had an error loading the grocery items. Try again';
      });
      return;
    }

    final Map<String, dynamic>? listData = json.decode(response.body);

    if (listData == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final List<GroceryItem> convertedGroceryItems = [];

    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere(
              (element) => element.value.title == item.value['category'])
          .value;

      convertedGroceryItems.add(GroceryItem(
        id: item.key,
        name: item.value['name'],
        quantity: item.value['quantity'],
        category: category,
      ));
    }

    setState(() {
      _groceryItems = convertedGroceryItems;
      _isLoading = false;
    });
  }

  void _addItem() async {
    final addedItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (ctx) => const NewItem()),
    );

    if (addedItem == null) return;

    setState(() {
      _groceryItems.add(addedItem);
    });
  }

  void removeItem(GroceryItem groceryItem) async {
    final index = _groceryItems.indexOf(groceryItem);

    setState(() {
      _groceryItems.add(groceryItem);
    });

    final url = Uri.https(
      'shopping-list-ebc83-default-rtdb.firebaseio.com',
      'shopping-list/${groceryItem.id}.json',
    );

    final response = await http.delete(url);

    if (response.statusCode != 200 && response.statusCode != 201) {
      setState(() {
        _groceryItems.insert(index, groceryItem);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Oh oh ... nothing here!',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
          const SizedBox(height: 16),
          // SizedBox(height: 16),
          Text(
            'Try adding a new item to the list :]',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
        ],
      ),
    );

    if (_groceryItems.isNotEmpty) {
      content = Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.separated(
          itemCount: _groceryItems.length,
          itemBuilder: (ctx, index) => GroceryListItem(
            groceryItem: _groceryItems[index],
            removeItem: removeItem,
          ),
          separatorBuilder: (ctx, index) => const SizedBox(height: 20),
        ),
      );
    }

    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      content = Center(child: Text(_error!));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
