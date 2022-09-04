import 'dart:io';

import 'package:flutter/material.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';

class Places with ChangeNotifier {
  static const placesTable = 'places';
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> fetchPlaces() async {
    final data = await DBHelper.get(placesTable);
    _items = data
        .map((item) => Place(
              id: item['id'],
              image: File(item['image']),
              location: Location(latitude: 0, longitude: 0),
              title: item['title'],
            ))
        .toList();
    notifyListeners();

    return Future.value();
  }

  Future<void> addPlace(String title, File image) async {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: Location(latitude: 0, longitude: 0),
      image: image,
    );
    _items.add(newPlace);
    notifyListeners();
    await DBHelper.insert(placesTable, {
      'id': newPlace.id,
      'title': title,
      'image': image.path,
    });
    return Future.value();
  }
}
