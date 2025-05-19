import 'package:flutter/material.dart';

class FiltersSwitchItem extends StatelessWidget {
  const FiltersSwitchItem({
    super.key,
    required this.value,
    required this.onTap,
    required this.title,
    required this.subtitle,
  });

  final bool value;
  final void Function(bool arg) onTap;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      onChanged: onTap,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}
