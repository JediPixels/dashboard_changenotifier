import 'package:flutter/material.dart';

class Section {
  int espresso = 0;
  int coffee = 0;
  int latte = 0;

  Section(
      {required this.espresso,
      required this.coffee,
      required this.latte});
}

class CoffeeChangeNotifier extends ChangeNotifier {
  late Section section;

  void addNumberOfCoffee({required int espresso, required int coffee, required int latte}) {
    section.espresso += espresso;
    section.coffee += coffee;
    section.latte += latte;
    notifyListeners();
  }
}

class TotalCoffeeChangeNotifier extends ChangeNotifier {
  int totalCoffee = 0;

  void totalNumberOfCoffee({required int espresso, required int coffee, required int latte}) {
    totalCoffee = espresso + coffee + latte;
    notifyListeners();
  }
}
