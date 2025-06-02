import 'package:meals/models/meal.dart';
import 'package:riverpod/riverpod.dart';

class Favoritesnotifier extends StateNotifier<List<Meal>> {
  Favoritesnotifier() : super([]);

  bool toggleFavorite(Meal meal) {
    final MealIsFavorite = state.contains(meal);

    if (MealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final FavoritesProvider = StateNotifierProvider<Favoritesnotifier, List<Meal>>((
  ref,
) {
  return Favoritesnotifier();
});
