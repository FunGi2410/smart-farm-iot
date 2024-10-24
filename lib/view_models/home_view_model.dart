import 'package:flutter/material.dart';
import 'package:smart_farm_iot/models/device.dart';
import 'package:smart_farm_iot/models/employee.dart';
import 'package:smart_farm_iot/models/job.dart';
import '../models/area.dart';
import 'dart:math';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    //================ TEST =====================
    addArea(
      'An Giang',
      'Lúa',
    );

    areas[0].employees = [
      Employee(name: 'Nhân viên 1', date: DateTime.now()),
      Employee(name: 'Nhân viên 2', date: DateTime.now()),
      Employee(name: 'Nhân viên 3', date: DateTime.now()),
      Employee(name: 'Nhân viên 4', date: DateTime.now()),
      Employee(name: 'Nhân viên 5', date: DateTime.now()),
    ];
  }

  Random random = Random();

  List<Area> _areas = [];
  List<Area> get areas => _areas;

  Future<void> addArea(String nameArea, String namePlant) async {
    Area area = Area(
      id: random.nextInt(100),
      nameArea: nameArea,
      namePlant: namePlant,
      img: '',
      devices: [
        Device(name: 'Bơm nước'),
        Device(name: 'Đèn sưởi'),
      ],
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