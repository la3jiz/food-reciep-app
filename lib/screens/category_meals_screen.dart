import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';
import '../resources/dummy_data.dart';

class CategoryMealsScreen extends StatefulWidget {
  static final route = '/category-meals';

  final List<Meal> _availableMeal;
  CategoryMealsScreen(this._availableMeal);
  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  // final String CategoryId;
  List<Meal> _categoryMeals = [];
  String _categoryTitle = '';
  var _didInitialized = false;
  @override

  /* initialstate runs to early even before the widget build thats why it throw error because we used context*/
  // void initState() {
  //   final _categoryFromRoute =
  //       ModalRoute.of(context)!.settings.arguments as Category;
  //   _categoryTitle = _categoryFromRoute.title;
  //   _categoryMeals = DUMMY_MEALS
  //       .where((meal) => meal.categories.contains(_categoryFromRoute.id))
  //       .toList();

  //   super.initState();
  // }

/*runs on every change it runs before the widget build and runs another time after the widget build */
  @override
  void didChangeDependencies() {
    if (!_didInitialized) {
      final _categoryFromRoute =
          ModalRoute.of(context)!.settings.arguments as Category;
      _categoryTitle = _categoryFromRoute.title;
      _categoryMeals = widget._availableMeal
          .where((meal) => meal.categories.contains(_categoryFromRoute.id))
          .toList();
      _didInitialized = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      _categoryMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (_, index) => MealItem(
          id: _categoryMeals[index].id,
          title: _categoryMeals[index].title,
          imageUrl: _categoryMeals[index].imageUrl,
          duration: _categoryMeals[index].duration,
          complexity: _categoryMeals[index].complexity,
          affordability: _categoryMeals[index].affordability,
          deleteHandler: _removeMeal,
        ),
        itemCount: _categoryMeals.length,
      ),
    );
  }
}
