import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final Color color;

  const Category(
      {required this.id, required this.title, this.color = Colors.orange});

  // String get getId {
  //   return this.id;
  // }

  // void set setId(String id) {
  //   this.id = id;
  // }

  // String get getTitle {
  //   return this.title;
  // }

  // void set setTitle(String title) {
  //   this.title = title;
  // }

  // Color get getColor {
  //   return this.color;
  // }

  // void set setColor(Color color) {
  //   this.color = color;
  // }
}
