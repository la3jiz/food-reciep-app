import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static final String route = '/filter-screen';

  final Map<String, bool> _currentFilters;
  final Function _filterHandler;

  FilterScreen(this._currentFilters, this._filterHandler);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _isGlutenFree = false;
  var _isLactoseFree = false;
  var _isVegan = false;
  var _isVegetarian = false;

  @override
  void initState() {
   _isGlutenFree = widget._currentFilters['gluten'] as bool;
   _isLactoseFree = widget._currentFilters['lactose'] as bool;
   _isVegan = widget._currentFilters['vegan'] as bool;
   _isVegetarian = widget._currentFilters['vegetarian'] as bool; 
      super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Filters"),
        actions: [
          IconButton(
              onPressed: () {
                final _selectedFilters = {
                  'gluten': _isGlutenFree,
                  'lactose': _isLactoseFree,
                  'vegan': _isVegan,
                  'vegetarian': _isVegetarian,
                };
                widget._filterHandler(_selectedFilters);
              },
              icon: Icon(Icons.save))
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(25),
            child: Text(
              'Adjust your meals selection:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                SwitchListTile(
                  value: _isGlutenFree,
                  title: Text('Gluten-free'),
                  subtitle: Text('Only includes gluten-free meals'),
                  onChanged: (newValue) => setState(() {
                    _isGlutenFree = newValue;
                  }),
                ),
                SwitchListTile(
                  value: _isLactoseFree,
                  title: Text('Lactose-free'),
                  subtitle: Text('Only includes Lactose-free meals'),
                  onChanged: (newValue) => setState(() {
                    _isLactoseFree = newValue;
                  }),
                ),
                SwitchListTile(
                  value: _isVegan,
                  title: Text('Vegan'),
                  subtitle: Text('Only includes Vegan meals'),
                  onChanged: (newValue) => setState(() {
                    _isVegan = newValue;
                  }),
                ),
                SwitchListTile(
                  value: _isVegetarian,
                  title: Text('Vegetarian'),
                  subtitle: Text('Only includes Vegetarian meals'),
                  onChanged: (newValue) => setState(() {
                    _isVegetarian = newValue;
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
