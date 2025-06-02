import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';

class SetFilter extends ConsumerWidget {
  const SetFilter({super.key});

  // class _SetFilterState extends ConsumerState<SetFilter> {
  //   var _glutenFree = false;
  //   var _lactoseFree = false;
  //   var _vegetarian = false;
  //   var _vegan = false;

  //   @override
  //   void initState() {
  //     super.initState();
  //     final activeFilters = ref.read(filtersProvider);
  //     _glutenFree = activeFilters[Filter.glutenFree]!;
  //     _lactoseFree = activeFilters[Filter.lactoseFree]!;
  //     _vegetarian = activeFilters[Filter.vegetarian]!;
  //     _vegan = activeFilters[Filter.vegan]!;
  //   }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    return
    // PopScope(
    //   canPop: true,
    //   onPopInvokedWithResult: (bool didPop, dynamic result) async {
    //     ref.read(filtersProvider.notifier).setFilters({
    //       Filter.glutenFree: _glutenFree,
    //       Filter.lactoseFree: _lactoseFree,
    //       Filter.vegetarian: _vegetarian,
    //       Filter.vegan: _vegan,
    //     });
    //   },
    // child:
    SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 40),
        child: Column(
          children: [
            Text(
              'Choose your filter!',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 27,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            SizedBox(height: 10),
            SwitchListTile(
              value: activeFilters[Filter.glutenFree]!,
              onChanged: (onChanged) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.glutenFree, onChanged);
              },
              title: Text(
                'Gluten Free',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              subtitle: Text('only Gluten free meals'),
            ),
            SwitchListTile(
              value: activeFilters[Filter.lactoseFree]!,
              onChanged: (onChanged) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.lactoseFree, onChanged);
              },
              title: Text(
                'Lactose Free',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              subtitle: Text('only Dairy free meals'),
            ),
            SwitchListTile(
              value: activeFilters[Filter.vegetarian]!,
              onChanged: (onChanged) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.vegetarian, onChanged);
              },
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              subtitle: Text('only Vegetarian meals'),
            ),
            SwitchListTile(
              value: activeFilters[Filter.vegan]!,
              onChanged: (onChanged) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.vegan, onChanged);
              },
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              subtitle: Text('only Vegan meals'),
            ),
          ],
        ),
      ),
    );
  }
}
