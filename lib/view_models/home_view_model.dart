import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smart_farm_iot/constants.dart';
import 'package:smart_farm_iot/models/device.dart';
import 'package:smart_farm_iot/models/employee.dart';
import 'package:smart_farm_iot/models/job.dart';
import '../models/area.dart';
import 'dart:math';
import 'package:http/http.dart' as http;

class HomeViewModel extends ChangeNotifier {
  // HomeViewModel() {
  //   //================ TEST =====================
  //   addArea(
  //     'An Giang',
  //     'Lúa',
  //   );

  //   areas[0].employees = [
  //     Employee(name: 'Nhân viên 1', date: DateTime.now()),
  //     Employee(name: 'Nhân viên 2', date: DateTime.now()),
  //     Employee(name: 'Nhân viên 3', date: DateTime.now()),
  //     Employee(name: 'Nhân viên 4', date: DateTime.now()),
  //     Employee(name: 'Nhân viên 5', date: DateTime.now()),
  //   ];
  // }

  Random random = Random();

  List<Area> _areas = [];
  List<Area> get areas => _areas;

  Future<void> addArea(String nameArea, String namePlant, String userId) async {
    addAreaToDatabase(nameArea, namePlant, userId);

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

  Future<void> removeArea(String makhuvuc, BuildContext context) async {
    final response = await http.post(
      Uri.parse('${Constants.url}/doan/deletekhuvuc.php'),
      body: {
        'makhuvuc': makhuvuc,
      },
    );

    final responseData = json.decode(response.body);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(responseData['message'])),
    );

    if (responseData['status'] == 'success') {
      print("delete success");
    }

    notifyListeners();
  }

  Future<List> getDataArea(int userId) async {
    final response = await http.get(Uri.parse('${Constants.url}/doan/getkhuvuc.php?user_id=$userId'));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load khu vuc');
    }
  }

  void addJobToArea(int areaIndex, String name, String notes, DateTime date) {
    areas[areaIndex].jobs.add(Job(name: name, notes: notes, date: date));
    notifyListeners();
  }

  void addAreaToDatabase(String nameArea, String namePlant, String userId) {
    var url = '${Constants.url}/doan/addkhuvuc.php';

    http.post(Uri.parse(url), body: {
      'user_id': userId,
      'makhuvuc': random.nextInt(100).toString(),
      'tenkhuvuc': nameArea,
      'tencaytrong': namePlant,
      'diachi': "234",
    }).then((response) {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      if (response.statusCode == 200) {
        print('Operation successful');
      } else {
        print('Operation failed');
      }
    });
  }
}