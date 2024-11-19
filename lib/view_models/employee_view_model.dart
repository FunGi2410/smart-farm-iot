import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:smart_farm_iot/constants.dart';
import 'package:smart_farm_iot/models/job.dart';
import 'package:http/http.dart' as http;

class EmployeeViewModel with ChangeNotifier {
  Future<List<dynamic>> getEmployee(int userId, String makhuvuc) async {
    try {
      final response = await http.get(Uri.parse(
          '${Constants.url}/doan/getnhanvien.php?user_id=${userId}&makhuvuc=${makhuvuc}'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load employees: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load employees: $e');
    }
  }
}