import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:registro_lotes_app/acre.dart';
import 'package:registro_lotes_app/app_state.dart';
import 'package:geocoding/geocoding.dart';

class RegisterScreen extends StatefulWidget {
  final Acre acre;

  const RegisterScreen(this.acre);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _addressController = TextEditingController();
  LatLng? _coordinates;

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _fetchLocationFromAddress() async {
    final address = widget.acre.address;
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        setState(() {
          _coordinates = LatLng(locations.first.latitude, locations.first.longitude);
        });
      } else {
        // Handle case when no location is found for the given address
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Location not found'),
            content: const Text('Unable to find the location for the given address.'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Handle any errors that occur during geocoding
      print('Error fetching location from address: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Lote'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _coordinates ?? widget.acre.coordinates!,
              zoom: 12,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('acre_location'),
                position: _coordinates ?? widget.acre.coordinates!,
              ),
            },
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              width: 350,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: ExpansionTile(
                        title: Text(
                          'Informações',
                          style: TextStyle(fontSize: 18),
                        ),
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.acre.description,
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 10),
                              Column(
                                children: [
                                  Container(
                                    child: Text(
                                      widget.acre.address,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.lime,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Container(
                                    child: Text(
                                      '${widget.acre.size} m2',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.lime,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Preço: \$${widget.acre.price.toStringAsFixed(2)}',
                                style: const TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Search for Address',
                                style: TextStyle(fontSize: 16),
                              ),
                              TextField(
                                controller: _addressController,
                                decoration: const InputDecoration(
                                  labelText: 'Address',
                                ),
                              ),
                              ElevatedButton(
                                child: const Text('Search'),
                                onPressed: _fetchLocationFromAddress,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

