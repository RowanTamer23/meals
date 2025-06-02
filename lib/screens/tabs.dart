import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/favorites_provider.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/drawer.dart';
import 'package:meals/widgets/filters.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

var kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int selectedIndex = 0;
  // final List<Meal> _favoriteMeals = [];

  // void toggleFavorite(Meal meal) {
  //   final isExisting = _favoriteMeals.contains(meal);
  //   if (isExisting) {
  //     setState(() {
  //       _favoriteMeals.remove(meal);
  //       showMessage('Meal removed from favorite!');
  //     });
  //   } else {
  //     setState(() {
  //       _favoriteMeals.add(meal);
  //       showMessage('Meal marked as favorite!');
  //     });
  //   }
  // }

  void _SelectedPage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    if (identifier == 'filters') {
      await showModalBottomSheet<Map<Filter, bool>>(
        context: context,
        builder: (ctx) => const SetFilter(),
        isScrollControlled: true,
      );
      // setState(() {
      //   _selectedFilters = result ?? kInitialFilters;
      // });
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activeScreen = categoriesScreen(availableMeals: availableMeals);
    String activePageTitle = 'Categories';

    if (selectedIndex == 1) {
      final favoriteMeal = ref.watch(FavoritesProvider);
      activePageTitle = 'Favorites';
      activeScreen = MealsScreen(meals: favoriteMeal);
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: _SelectedPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
