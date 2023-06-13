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
              target: widget.acre.coordinates!,
              zoom: 12,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('acre_location'),
                position: widget.acre.coordinates!,
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
