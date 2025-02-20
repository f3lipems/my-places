import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:io';

import 'package:my_places/models/place.dart';
import 'package:my_places/utils/app_db.dart';

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
        location: PlaceLocation(address: '', latitude: 0, longitude: 0),
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

  void addPlace(String title, File image) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: PlaceLocation(address: '', latitude: 0, longitude: 0),
      image: image,
    );

    AppDb.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });

    loadPlaces();
    
    notifyListeners();
  }
}