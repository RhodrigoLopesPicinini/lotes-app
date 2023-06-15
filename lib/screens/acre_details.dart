import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:registro_lotes_app/features/acre.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AcreDetailsScreen extends StatelessWidget {
  final Acre acre;
  final String userName;
  final String userEmail;
  final String userPhone;

  const AcreDetailsScreen({
    super.key,
    required this.acre,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
  });

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
              target: acre.coordinates!,
              zoom: 18,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('acre_location'),
                position: acre.coordinates!,
              ),
            },
          ),
          Positioned(
            top: 20,
            left: 20,
            child: SizedBox(
              width: 350,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      // width: double.infinity,
                      child: ExpansionTile(
                        title: const Text(
                          'Informações',
                          style: TextStyle(fontSize: 18),
                        ),
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                acre.description,
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.lime,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      acre.address,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.lime,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      '${acre.size} m2',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Preço: R\$${NumberFormat.currency(locale: 'pt_BR', symbol: '').format(acre.price)}',
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ExpansionTile(
                        title: const Text(
                          'Informações do Usuário',
                          style: TextStyle(fontSize: 18),
                        ),
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name: $userName',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Email: $userEmail',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Phone: $userPhone',
                                style: const TextStyle(fontSize: 16),
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
