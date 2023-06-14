import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:registro_lotes_app/states/acres_state.dart';
import 'package:registro_lotes_app/acre_details.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:registro_lotes_app/account.dart';
import 'package:registro_lotes_app/acre.dart';
import 'package:registro_lotes_app/states/users_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Acre> boughtAcres = [];

  @override
  void initState() {
    super.initState();
    Provider.of<AcresState>(context, listen: false).loadAcres();
  }

  void _editAcre(int index, Acre editedAcre) {
    Provider.of<AcresState>(context, listen: false).editAcre(index, editedAcre);
  }

  Future<LatLng> _getCoordinatesFromAddress(String address) async {
    List<Location> locations = await locationFromAddress(address);
    return LatLng(locations.first.latitude, locations.first.longitude);
  }

  void _openCreateAcreDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String description = '';
        String address = '';
        double size = 0.0;
        double price = 0.0;

        return AlertDialog(
          title: const Text('Registrar Lote'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Descrição'),
                onChanged: (value) {
                  description = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Endereço'),
                onChanged: (value) {
                  address = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Tamanho (m2)'),
                onChanged: (value) {
                  size = double.parse(value);
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Preço'),
                onChanged: (value) {
                  price = double.parse(value);
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8.0),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Salvar'),
              onPressed: () async {
                LatLng? coordinates = await _getCoordinatesFromAddress(address);

                if (coordinates != null) {
                  Provider.of<AcresState>(context, listen: false).createAcre(
                    description,
                    address,
                    size,
                    price,
                    coordinates,
                  );

                  Navigator.pop(context);
                } else {
                  // Handle error case when coordinates are not found for the address.
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Erro'),
                        content: const Text(
                            'Não foi possível obter as coordenadas do endereço.'),
                        actions: [
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _openEditAcreDialog(Acre acre, int index) {
    showDialog(
      context: context,
      builder: (context) {
        String description = acre.description;
        String address = acre.address;
        double size = acre.size;
        double price = acre.price;

        return AlertDialog(
          title: const Text('Alterar Lote'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Descrição'),
                onChanged: (value) {
                  description = value;
                },
                controller: TextEditingController(text: description),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Endereço'),
                onChanged: (value) {
                  address = value;
                },
                controller: TextEditingController(text: address),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Tamanho (m2)'),
                onChanged: (value) {
                  size = double.parse(value);
                },
                controller: TextEditingController(text: size.toString()),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Preço'),
                onChanged: (value) {
                  price = double.parse(value);
                },
                keyboardType: TextInputType.number,
                controller: TextEditingController(text: price.toString()),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Salvar'),
              onPressed: () async {
                LatLng? coordinates = await _getCoordinatesFromAddress(address);

                setState(() {
                  Acre editedAcre = Acre(
                    description: description,
                    address: address,
                    size: size,
                    price: price,
                    coordinates: coordinates,
                  );
                  _editAcre(index, editedAcre);
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.grass),
            Text('LOTES BUSINESS'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AccountScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openCreateAcreDialog,
          ),
        ],
      ),
      body: Consumer2<AcresState, UsersState>(
        builder: (context, acresState, usersState, _) {
          return ListView.builder(
            itemCount: acresState.acres.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  title: Text(acresState.acres[index].address,
                      style: const TextStyle(fontSize: 14)),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    IconButton(
                      onPressed: () {
                        _openEditAcreDialog(acresState.acres[index], index);
                      },
                      icon: const Icon(Icons.border_color_sharp),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'R\$ ${acresState.acres[index].price.toStringAsFixed(2)}',
                        ),
                      ],
                    ),
                  ]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AcreDetailsScreen(
                          acre: acresState.acres[index],
                          userName: usersState.user.name,
                          userEmail: usersState.user.email,
                          userPhone: usersState.user.phoneNumber,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
