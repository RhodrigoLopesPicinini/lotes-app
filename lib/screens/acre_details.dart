import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:registro_lotes_app/features/acre.dart';

class AcreDetailsScreen extends StatefulWidget {
  final Acre acre;
  final String userName;
  final String userEmail;
  final String userPhone;

  const AcreDetailsScreen({
    required this.acre,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
  });

  @override
  _AcreDetailsScreenState createState() => _AcreDetailsScreenState();
}

class _AcreDetailsScreenState extends State<AcreDetailsScreen> {
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
              zoom: 16,
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
                        title: const Text(
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
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      child: ExpansionTile(
                        title: Text(
                          'Informações do Usuário',
                          style: TextStyle(fontSize: 18),
                        ),
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name: ${widget.userName}',
                                style: TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Email: ${widget.userEmail}',
                                style: TextStyle(fontSize: 14),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Phone: ${widget.userPhone}',
                                style: TextStyle(fontSize: 14),
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
