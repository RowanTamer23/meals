import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDeet extends ConsumerWidget {
  const MealDeet({super.key, required this.meal});
  final Meal meal;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(FavoritesProvider).contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(FavoritesProvider.notifier)
                  .toggleFavorite(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    wasAdded
                        ? 'Meal added to favorites'
                        : 'Meal removed from favorites',
                  ),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween(begin: 0.93, end: 1.0).animate(animation),
                  child: child,
                );
              },
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                key: ValueKey(isFavorite),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                width: double.infinity,
                fit: BoxFit.fill,
                height: 250,
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Ingredients ',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 30,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 10),
            for (final ingredient in meal.ingredients)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 2,
                ),
                child: Text(
                  ingredient,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            SizedBox(height: 30),
            Text(
              'How to cook ',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 30,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 10),
            for (final step in meal.steps)
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 8, 50, 8),
                child: Text(
                  step,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
