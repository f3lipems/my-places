import 'package:flutter/material.dart';
import 'dart:io';

import 'package:my_places/models/place.dart';

class GratePlace with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  Place itemByIndex(int index) {
    return _items[index];
  }

  void addPlace(String title, PlaceLocation location, File image) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: location,
      image: image,
    );
    _items.add(newPlace);
    notifyListeners();
  }
}