import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/widgets/filters_switch_item.dart';

import 'package:meals_app/providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(filtersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: [
          FiltersSwitchItem(
            value: filters[Filter.glutenFree]!,
            onTap: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.glutenFree, isChecked);
            },
            title: 'Gluten-free',
            subtitle: 'Only include gluten-free meals.',
          ),
          FiltersSwitchItem(
            value: filters[Filter.lactoseFree]!,
            onTap: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChecked);
            },
            title: 'Lactose-free',
            subtitle: 'Only include lactose-free meals.',
          ),
          FiltersSwitchItem(
            value: filters[Filter.vegetarian]!,
            onTap: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, isChecked);
            },
            title: 'Vegetarian',
            subtitle: 'Only include vegetarian meals.',
          ),
          FiltersSwitchItem(
            value: filters[Filter.vegan]!,
            onTap: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
            },
            title: 'Vegan',
            subtitle: 'Only include vegan meals.',
          ),
        ],
      ),
    );
  }
}
