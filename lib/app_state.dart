import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:registro_lotes_app/acre.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  List<Acre> acres = [];
  List<Acre> boughtAcres = [];

  void loadAcres() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> acreList = prefs.getStringList('acres') ?? [];

    acres = acreList.map((json) => Acre.fromJson(jsonDecode(json))).toList();
    notifyListeners();
  }

  void saveAcres() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> acreList = acres.map((acre) => jsonEncode(acre.toJson())).toList();

    await prefs.setStringList('acres', acreList);
  }

  void editAcre(index, Acre editedAcre) {
    acres[index] = editedAcre;
    saveAcres();
    notifyListeners();
  }

  void buyAcre(Acre acre) {
    acre.isSold = true;
    boughtAcres.add(acre);
    saveAcres();
    notifyListeners();
  }

  void createAcre(String description, String address, double size, double price, LatLng coordinates) {
    acres.add(Acre(
      description: description,
      address: address,
      size: size,
      price: price,
      coordinates: coordinates,
    ));
    saveAcres();
    notifyListeners();
  }
}