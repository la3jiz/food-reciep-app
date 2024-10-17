import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import './categories_screen.dart';
import './favorites_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> _favoriteMeals;

  TabsScreen(this._favoriteMeals);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages=[] ;

  int _selectedIndex = 0;

  @override
  void initState() {
_pages=[
    {'page': CategoriesScreen(), 'title': 'Categories'},
    {'page': FavoritesScreen(widget._favoriteMeals), 'title': 'Your Favorites'},
  ];    super.initState();
  }

  //flutter will give you th e index automatically you don't need to pass it in --note:thid only when use BottomNavigationBar widget
  void _selectedPage(int index) {
    setState(() => _selectedIndex = index);
  }

  Widget _buildListTile(String title, IconData icon) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
            fontSize: 24),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedIndex]['title'] as String),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.shifting,
        onTap:_selectedPage,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            // backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.start),
            label: 'Favorites',
          ),
        ],
      ),
    );

    /*top tab bar */
    // return DefaultTabController(
    //   length: 2,
    //   //initialIndex: 1,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: Text('Meals'),
    //       bottom: TabBar(
    //         tabs: [
    //           Tab(
    //             icon: Icon(Icons.category),
    //             text: 'Categories',
    //           ),
    //           Tab(
    //             icon: Icon(Icons.star),
    //             text: 'Favorites',
    //           ),
    //         ],
    //       ),
    //     ),
    //     body: TabBarView(children: [CategoriesScreen(), FavoritesScreen()]),
    //   ),
    // );
  }
}
