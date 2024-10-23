import 'package:flutter/material.dart';
import 'package:smart_farm_iot/models/job.dart';
import '../models/area.dart';
import 'dart:math';

class HomeViewModel extends ChangeNotifier {
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
    notifyListeners();
  }

  void removeArea(int index) {
    areas.removeAt(index);
    notifyListeners();
  }

  void addJobToArea(int areaIndex, String name, String notes, DateTime date) {
    areas[areaIndex].jobs.add(Job(name: name, notes: notes, date: date));
    notifyListeners();
  }
}