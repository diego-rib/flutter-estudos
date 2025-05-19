import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';

class GroceryListItem extends StatelessWidget {
  const GroceryListItem({
    super.key,
    required this.groceryItem,
    required this.removeItem,
  });

  final GroceryItem groceryItem;

  final void Function(GroceryItem groceryItem) removeItem;

  get name {
    return '${groceryItem.name[0].toUpperCase()}${groceryItem.name.substring(1)}';
  }

  get color {
    return groceryItem.category.color;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(name),
      onDismissed: (direction) {
        removeItem(groceryItem);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 20.0,
                height: 20.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color),
                ),
              ),
              const SizedBox(width: 20),
              Text(name),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              '${groceryItem.quantity}',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
