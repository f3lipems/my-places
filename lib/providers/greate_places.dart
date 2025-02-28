import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io';

import 'package:my_places/models/place.dart';
import 'package:my_places/utils/app_db.dart';
import 'package:my_places/utils/app_locations.dart';

class GreatePlaces with ChangeNotifier {
  final List<Place> _items = [];

  List<Place> get items => [..._items];

  Future<void> loadPlaces() async {
    final dataList = await AppDb.getData('places');
    _items.clear();
    for (var item in dataList) {
      _items.add(Place(
        id: item['id'],
        title: item['title'],
        image: File(item['image']),
        location: PlaceLocation(address: item['address'], latitude: item['latitude'], longitude: item['longitude']),
      ));
    }
    notifyListeners();
  }

  int get itemsCount {
    return _items.length;
  }

  Place itemByIndex(int index) {
    return _items[index];
  }

  Future<void>  addPlace(String title, File image, LatLng position) async {
    String address = await AppLocations.getAddressFrom(position);

    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: PlaceLocation(address: address, latitude: position.latitude, longitude: position.longitude),
      image: image,
    );


    AppDb.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'latitude': newPlace.location.latitude,
      'longitude': newPlace.location.longitude,
      'address': newPlace.location.address,
    });

    loadPlaces();
    
    notifyListeners();
  }
}