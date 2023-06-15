import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registro_lotes_app/features/acre.dart';
import 'package:registro_lotes_app/services/geocoding_service.dart';
import 'package:registro_lotes_app/states/acres_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AcreDialogUtils {

  void openCreateAcreDialog(BuildContext context) {
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
                try {
                  LatLng coordinates =
                  await GeocodingService.getCoordinatesFromAddress(address);
                  if (context.mounted) {
                    Provider.of<AcresState>(context, listen: false).createAcre(
                      description,
                      address,
                      size,
                      price,
                      coordinates,
                    );
                    Navigator.pop(context);
                  }
                } catch (e) {
                  _showErrorDialog(context, 'Ocorreu um erro. Tente novamente.');
                }
              },
            ),
          ],
        );
      },
    );
  }

  void openEditAcreDialog(BuildContext context, Acre acre, int index) {
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
                LatLng coordinates =
                await GeocodingService.getCoordinatesFromAddress(address);
                if (context.mounted) {
                  Provider.of<AcresState>(context, listen: false)
                      .editAcre(index, Acre(
                    description: description,
                    address: address,
                    size: size,
                    price: price,
                    coordinates: coordinates,
                  ));
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showErrorDialog(BuildContext context, String message) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Erro'),
          content: Text(message),
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
}