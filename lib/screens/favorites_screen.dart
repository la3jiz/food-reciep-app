import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/meal_item.dart';
import '../models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> _favoriteMeals;

  FavoritesScreen(this._favoriteMeals);

  @override
  Widget build(BuildContext context) {
    if (_favoriteMeals.isEmpty)
      return Center(
        child: Text('you have not favorites yet !'),
      );
    else
      return ListView.builder(
        itemBuilder: (_, index) => MealItem(
          id: _favoriteMeals[index].id,
          title: _favoriteMeals[index].title,
          imageUrl: _favoriteMeals[index].imageUrl,
          duration: _favoriteMeals[index].duration,
          complexity: _favoriteMeals[index].complexity,
          affordability: _favoriteMeals[index].affordability,
          deleteHandler: () => null,
        ),
        itemCount: _favoriteMeals.length,
      );
  }
}
