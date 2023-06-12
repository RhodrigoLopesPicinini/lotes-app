import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registro_lotes_app/app_state.dart';
import 'package:registro_lotes_app/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:registro_lotes_app/account.dart';
import 'package:registro_lotes_app/acre.dart';
import 'dart:convert';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  List<Acre> acres = [];
  List<Acre> boughtAcres = [];

  @override
  void initState() {
    super.initState();
    Provider.of<AppState>(context, listen: false).loadAcres();
  }


  _loadAcres() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> acreList = prefs.getStringList('acres') ?? [];

    setState(() {
      acres = acreList.map((json) => Acre.fromJson(jsonDecode(json))).toList();
    });
  }

  _saveAcres() {
    Provider.of<AppState>(context, listen: false).saveAcres();
  }


  void _buyAcre(Acre acre) {
    Provider.of<AppState>(context, listen: false).buyAcre(acre);
  }

  void _editAcre(index, Acre editedAcre) {
    Provider.of<AppState>(context, listen: false).editAcre(index, editedAcre);
  }


 void _openCreateAcreDialog() {
  showDialog(
    context: context,
    builder: (context) {
      String name = '';
      String description = '';
      double price = 0.0;
      LatLng? coordinates;

      return AlertDialog(
        title: const Text('Create Acre'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (value) {
                name = value;
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Description'),
              onChanged: (value) {
                description = value;
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Price'),
              onChanged: (value) {
                price = double.parse(value);
              },
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8.0),
            TextField(
              decoration: const InputDecoration(labelText: 'Coordinates'),
              onChanged: (value) {
                // Parse the coordinates input into LatLng object
                List<String> coords = value.split(',');
                double latitude = double.tryParse(coords[0].trim()) ?? 0.0;
                double longitude = double.tryParse(coords[1].trim()) ?? 0.0;
                coordinates = LatLng(latitude, longitude);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text('Save'),
            onPressed: () {
              if (coordinates != null) {
                Provider.of<AppState>(context, listen: false).createAcre(
                  name,
                  description,
                  price,
                  coordinates!,
                );
              }
              Navigator.pop(context);
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
      String name = acre.name;
      String description = acre.description;
      double price = acre.price;
      LatLng coordinates = acre.coordinates!;

      return AlertDialog(
        title: const Text('Edit Acre'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (value) {
                name = value;
              },
              controller: TextEditingController(text: name),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Description'),
              onChanged: (value) {
                description = value;
              },
              controller: TextEditingController(text: description),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Price'),
              onChanged: (value) {
                price = double.parse(value);
              },
              keyboardType: TextInputType.number,
              controller: TextEditingController(text: price.toString()),
            ),
            const SizedBox(height: 8.0),
            TextField(
              decoration: const InputDecoration(labelText: 'Coordinates'),
              onChanged: (value) {
                List<String> coords = value.split(',');
                double latitude = double.tryParse(coords[0].trim()) ?? 0.0;
                double longitude = double.tryParse(coords[1].trim()) ?? 0.0;
                coordinates = LatLng(latitude, longitude);
              },
              controller: TextEditingController(
                text: '${coordinates.latitude}, ${coordinates.longitude}',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text('Save'),
            onPressed: () {
              setState(() {
                Acre editedAcre = Acre(
                  name: name,
                  description: description,
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
        title: Row(children: [
            const Icon(Icons.grass),
            const Text('LOTES BUSINESS'),
          ],),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountScreen(acres.length)),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openCreateAcreDialog,
          ),
        ],
      ),
      body: Consumer<AppState>(
        builder: (context, appState, _) {
          return ListView.builder(
            itemCount: appState.acres.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  title: Text(appState.acres[index].name),
                  subtitle: Text(appState.acres[index].description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    IconButton(
                      onPressed: () {
                        _openEditAcreDialog(appState.acres[index], index);
                      }, 
                      icon: const Icon(Icons.border_color_sharp)),
                    SizedBox(width: 10,),
                    Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('R\$ ${appState.acres[index].price.toStringAsFixed(2)}'),
                      appState.acres[index].isSold
                          ? const Text('Em negociação', style: TextStyle(color: Colors.red))
                          : ElevatedButton(
                              child: const Text('Negociar'),
                              onPressed: () {
                                _buyAcre(appState.acres[index]);
                              },
                            ),
                    ],
                  )]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen(appState.acres[index])),
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