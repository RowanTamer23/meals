import 'package:flutter/material.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class SetFilter extends StatefulWidget {
  const SetFilter({super.key, required this.currentFilter});
  final Map<Filter, bool> currentFilter;

  @override
  State<SetFilter> createState() {
    return _SetFilterState();
  }
}

class _SetFilterState extends State<SetFilter> {
  var _glutenFree = false;
  var _lactoseFree = false;
  var _vegetarian = false;
  var _vegan = false;

  @override
  void initState() {
    super.initState();
    _glutenFree = widget.currentFilter[Filter.glutenFree]!;
    _lactoseFree = widget.currentFilter[Filter.lactoseFree]!;
    _vegetarian = widget.currentFilter[Filter.vegetarian]!;
    _vegan = widget.currentFilter[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) return;
        Navigator.of(context).pop({
          Filter.glutenFree: _glutenFree,
          Filter.lactoseFree: _lactoseFree,
          Filter.vegetarian: _vegetarian,
          Filter.vegan: _vegan,
        });
      },
      child: SingleChildScrollView(
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
                value: _glutenFree,
                onChanged: (onChanged) {
                  setState(() {
                    _glutenFree = onChanged;
                  });
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
                value: _lactoseFree,
                onChanged: (onChanged) {
                  setState(() {
                    _lactoseFree = onChanged;
                  });
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
                value: _vegetarian,
                onChanged: (onChanged) {
                  setState(() {
                    _vegetarian = onChanged;
                  });
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
                value: _vegan,
                onChanged: (onChanged) {
                  setState(() {
                    _vegan = onChanged;
                  });
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
      ),
    );
  }
}
