import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  String name = '';
  String description = '';
  double price = 0.0;
  String coordinates = '';

  void updateName(String newName) {
    name = newName;
    notifyListeners();
  }

  void updateDescription(String newDescription) {
    description = newDescription;
    notifyListeners();
  }

  void updatePrice(double newPrice) {
    price = newPrice;
    notifyListeners();
  }

  void updateCoordinates(String newCoordinates) {
    coordinates = newCoordinates;
    notifyListeners();
  }
}
