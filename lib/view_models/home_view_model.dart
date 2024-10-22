import 'package:flutter/material.dart';
import '../models/area.dart';
import '../services/database_helper.dart';
import 'dart:math';

class HomeViewModel extends ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  Random random = Random();

  List<Area> _areas = [];
  List<Area> get areas => _areas;

  Future<void> addArea(String nameArea, String namePlant) async {
    Area area = Area(
      id: random.nextInt(100),
      nameArea: nameArea,
      namePlant: namePlant,
      img: '',
    );
    areas.add(area);
    // await _databaseHelper.insertArea(Area);
    // layareas();
    notifyListeners();
  }

  Future<void> getAreas() async {
    _areas = await _databaseHelper.getAreas();
    notifyListeners();
  }

  void removeArea(int index) {
    areas.removeAt(index);
    notifyListeners();
  }
}