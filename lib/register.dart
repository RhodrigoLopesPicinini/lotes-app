import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:registro_lotes_app/acre.dart';
import 'package:registro_lotes_app/app_state.dart';

class RegisterScreen extends StatelessWidget {
  final Acre acre;

  const RegisterScreen(this.acre);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    // Use appState properties in the UI
    final name = appState.name;
    final description = appState.description;
    final price = appState.price;
    final coordinates = appState.coordinates;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Acre Details'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: acre.coordinates,
              zoom: 15,
            ),
            markers: {Marker(markerId: const MarkerId('acre_location'), position: acre.coordinates)},
          ),
          Positioned(
            top: 20,
            left: 20,
            width: 500,
            height: 300,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    acre.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    acre.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Price: \$${acre.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16),
                    
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}