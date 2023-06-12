import 'package:google_maps_flutter/google_maps_flutter.dart';

class Acre {
  final String name;
  final String description;
  final double price;
  final LatLng coordinates;
  bool isSold;

  Acre({required this.name, required this.description, required this.price, required this.coordinates, this.isSold = false});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'coordinates': {
        'latitude': coordinates.latitude,
        'longitude': coordinates.longitude,
      },
    };
  }

  factory Acre.fromJson(Map<String, dynamic> json) {
    return Acre(
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      coordinates: LatLng(
        json['coordinates']['latitude'],
        json['coordinates']['longitude'],
      ),
    );
  }
}