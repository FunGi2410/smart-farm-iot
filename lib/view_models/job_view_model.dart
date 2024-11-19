import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:smart_farm_iot/constants.dart';
import 'package:smart_farm_iot/models/job.dart';
import 'package:http/http.dart' as http;

class JobViewModel with ChangeNotifier {
  List<Job> jobs = [];

  Future<List<dynamic>> getTask(int userId, String makhuvuc) async {
    try {
      final response = await http.get(Uri.parse(
          '${Constants.url}/doan/getcongviec.php?user_id=${userId}&makhuvuc=${makhuvuc}'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load tasks: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load tasks: $e');
    }
  }

  Future<void> removeTask(int id, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.url}/doan/deletecongviec.php'),
        body: {'id': id.toString()},
      );
      final responseData = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'])));
      if (responseData['status'] == 'success') {
        print("delete task success");
      }

      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete task: $e')));
    }
  }

  Future<void> addTask(String name, String notes, DateTime date, int userId, String makhuvuc, BuildContext context) async {
    final response = await http.post(
      Uri.parse('${Constants.url}/doan/addcongviec.php'),
      body: {
        'user_id': userId.toString(),
        'makhuvuc': makhuvuc,
        'congviec': name, 
        'ghichu': notes,
        'thoigian': date.toIso8601String().replaceAll('T', ' ').split('.')[0],
      },
    );

    final responseData = json.decode(response.body);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(responseData['message'])),
    );
    if (responseData['status'] == 'success') {
      Navigator.pop(context);
      notifyListeners();
    }
  }
}
