import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';

class CategoriesGridItem extends StatelessWidget {
  const CategoriesGridItem({
    super.key,
    required this.category,
    required this.Route,
  });

  final Category category;
  final void Function() Route;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: Route,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.5),
              category.color.withOpacity(0.9),
            ],
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
