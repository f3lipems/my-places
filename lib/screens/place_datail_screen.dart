import 'package:flutter/material.dart';
import 'package:my_places/models/place.dart';
import 'package:my_places/screens/map_screen.dart';

class PlaceDatailScreen extends StatelessWidget {
  const PlaceDatailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Place place = ModalRoute.of(context)?.settings.arguments as Place;

    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Column(
        spacing: 10,
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              place.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Text(
            place.location.address,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, color: Colors.grey),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.map),
            label: const Text('Visualizar no Mapa'),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapScreen(
                    isReadOnly: true,
                    initialLocation: place.location,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}