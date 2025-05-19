import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meals_list_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealsListItem extends StatelessWidget {
  const MealsListItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
  });

  final Meal meal;

  final void Function(Meal meal) onSelectMeal;

  get complexityName {
    return '${meal.complexity.name[0].toUpperCase()}${meal.complexity.name.substring(1)}';
  }

  get affordabilityName {
    return '${meal.affordability.name[0].toUpperCase()}${meal.affordability.name.substring(1)}';
  }

  @override
  Widget build(BuildContext context) {
    final mealDuration = meal.duration;

    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 5,
      child: InkWell(
        onTap: () {
          onSelectMeal(meal);
        },
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MealsListItemTrait(
                          icon: Icons.schedule,
                          label: '$mealDuration min',
                        ),
                        MealsListItemTrait(
                          icon: Icons.work,
                          label: complexityName,
                        ),
                        MealsListItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityName,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
