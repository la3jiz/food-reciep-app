import 'package:flutter/material.dart';

import './models/meal.dart';
import './resources/dummy_data.dart';
import './screens/filter_screen.dart';
import './screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';
import './screens/meal_details_sceen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeal = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeal = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] as bool && !meal.isGlutenFree) return false;
        if (_filters['lactose'] as bool && !meal.isLactoseFree) return false;
        if (_filters['vegan'] as bool && !meal.isVegan) return false;
        if (_filters['vegetarian'] as bool && !meal.isVegetarian) return false;
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      final meal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
      _favoriteMeals.add(meal);
    }
  }

  bool _isMealFavorite(String mealId) {
    return DUMMY_MEALS.any((meal) => meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        canvasColor: Color.fromRGBO(255, 255, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      title: 'Restaurant App',
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (_) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.route: (_) => CategoryMealsScreen(_availableMeal),
        MealDetailsScreen.route: (_) =>
            MealDetailsScreen(_toggleFavorite, _isMealFavorite),
        FilterScreen.route: (_) => FilterScreen(_filters, _setFilters),
      },
      /* for every route that is not defined in routes  property*/
      onGenerateRoute: (settings) {
        print(settings.arguments);
        // return MaterialPageRoute(builder: (_) => CategoriesScreen());
      },

      //page not found
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (_) => TabsScreen(_favoriteMeals));
      },
    );
  }
}



// class MyAppHomePage extends StatefulWidget {
//   @override
//   State<MyAppHomePage> createState() => _MyAppHomePageState();
// }

// class _MyAppHomePageState extends State<MyAppHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Restaurant App'),
//       ),
//       body: Center(
//         child: Text('My App'),
//       ),
//     );
//   }
// }
