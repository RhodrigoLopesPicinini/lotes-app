import 'package:google_maps_flutter/google_maps_flutter.dart';

class Acre {
  String description;
  String address;
  double price;
  double size;
  LatLng? coordinates;
  bool isSold;

  Acre({
    required this.description,
    required this.address,
    required this.price,
    required this.size,
    required this.coordinates,
    this.isSold = false
  });

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'address': address,
      'price': price,
      'coordinates': {
        'latitude': coordinates?.latitude,
        'longitude': coordinates?.longitude,
      },
      'size': size,
      'isSold': isSold,
    };
  }

  factory Acre.fromJson(Map<String, dynamic> json) {
    return Acre(
      description: json['description'],
      address: json['address'],
      size: json['size'].toDouble(),
      price: json['price'].toDouble(),
      coordinates: LatLng(
        json['coordinates']['latitude'],
        json['coordinates']['longitude'],
      ),
      isSold: json['isSold'],
    );
  }

  
}