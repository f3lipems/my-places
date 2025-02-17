import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:io';

import 'package:my_places/models/place.dart';
import 'package:my_places/utils/app_db.dart';

class GreatePlaces with ChangeNotifier {
  final List<Place> _items = [];

  List<Place> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  Place itemByIndex(int index) {
    return _items[index];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
      id: Random().nextDouble.toString(),
      title: title,
      location: PlaceLocation(address: '', latitude: 0, longitude: 0),
      image: image,
    );
    _items.add(newPlace);

    AppDb.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
    
    notifyListeners();
  }
}