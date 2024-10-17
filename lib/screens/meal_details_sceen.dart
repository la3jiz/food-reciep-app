import 'package:flutter/material.dart';

import '../resources/dummy_data.dart';

class MealDetailsScreen extends StatelessWidget {
  static final String route = '/meal-details';
  final Function _toggleFavorite;
  final Function _isMealFavorite;

  MealDetailsScreen(this._toggleFavorite, this._isMealFavorite);

  Widget _buildSectionTitle(BuildContext context, String text) => Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      );

  Widget _buildContainer(Widget child) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        padding: EdgeInsets.all(20),
        height: 200,
        width: double.infinity,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final String _mealID = ModalRoute.of(context)!.settings.arguments as String;
    final _selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == _mealID);

    return Scaffold(
      appBar: AppBar(title: Text(_selectedMeal.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: Image.network(
                _selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _buildSectionTitle(context, 'Ingrediants'),
            _buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    color: Colors.amber,
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(_selectedMeal.ingredients[index])),
                  );
                },
                itemCount: _selectedMeal.ingredients.length,
              ),
            ),
            _buildSectionTitle(context, 'Steps'),
            _buildContainer(
              ListView.builder(
                  itemBuilder: (ctx, index) => Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              child: Text('# ${index + 1}'),
                            ),
                            title: Text(_selectedMeal.steps[index]),
                          ),
                          Divider()
                        ],
                      ),
                  itemCount: _selectedMeal.steps.length),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(_isMealFavorite(_mealID) ? Icons.star : Icons.star_border),
        onPressed: () {
          _toggleFavorite(_mealID);
          /*if you want to turn it to delete button */
          // Navigator.of(context).pop(_mealID);
        },
      ),
    );
  }
}
