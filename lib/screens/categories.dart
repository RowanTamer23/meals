import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/categories_grid_item.dart';

class categoriesScreen extends StatefulWidget {
  const categoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<categoriesScreen> createState() => _categoriesScreenState();
}

class _categoriesScreenState extends State<categoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void SelectedRoute(BuildContext context, Category category) {
    final filteredMeals =
        widget.availableMeals
            .where((meal) => meal.categories.contains(category.id))
            .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (ctx) => MealsScreen(title: category.title, meals: filteredMeals),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: EdgeInsets.all(15),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 3 / 2,
        ),
        children: [
          // availableCategories.map((category) => CategoriesGridItem(category: category)).toList(),
          for (final category in availableCategories)
            CategoriesGridItem(
              Route: () {
                SelectedRoute(context, category);
              },
              category: category,
            ),
        ],
      ),
      builder:
          (context, child) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.9),
              end: const Offset(0, 0),
            ).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.easeInOut,
              ),
            ),
            child: child,
          ),

      // Padding(
      //   padding: EdgeInsetsGeometry.only(
      //     top: 500 - _animationController.value * 500,
      //   ),
      //   child: child,
      // ),
    );
  }
}
