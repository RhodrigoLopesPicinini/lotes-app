import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:registro_lotes_app/account.dart';
import 'package:registro_lotes_app/acre.dart';
import 'package:registro_lotes_app/app_state.dart';
import 'package:registro_lotes_app/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lotes App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: GoogleFonts.promptTextTheme(
          Theme.of(context).textTheme
        )
      ),
      home: FirstScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

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
    _loadAcres();
  }

  _loadAcres() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> acreList = prefs.getStringList('acres') ?? [];

    setState(() {
      acres = acreList.map((json) => Acre.fromJson(jsonDecode(json))).toList();
    });
  }

  _saveAcres() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> acreList = acres.map((acre) => jsonEncode(acre.toJson())).toList();
    await prefs.setStringList('acres', acreList);
  }

  void _buyAcre(Acre acre) {
    setState(() {
      acre.isSold = true; // Mark the acre as sold
      boughtAcres.add(acre); // Add the acre to the bought acres list
    });
    _saveAcres(); // Save the updated acres
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
                  setState(() {
                    acres.add(Acre(
                      name: name,
                      description: description,
                      price: price,
                      coordinates: coordinates!,
                    ));
                  });
                  _saveAcres();
                }
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
      body: ListView.builder(
        itemCount: acres.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
            title: Text(acres[index].name),
            subtitle: Text(acres[index].description),
            trailing: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('R\$ ${acres[index].price.toStringAsFixed(2)}'),
                acres[index].isSold
                  ? const Text('Em negociação', style: TextStyle(color: Colors.red))
                  : ElevatedButton(
                    child: const Text('Negociar'),
                    onPressed: () {
                      _buyAcre(acres[index]);
                    },
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterScreen(acres[index])),
              );
            },
          )
          );
        },
      ),
    );
  }
}