import 'package:flutter/material.dart';
import 'package:smart_farm_iot/models/job.dart';

class JobViewModel with ChangeNotifier {
  List<Job> jobs = [];

  void addJob(String name, String notes, DateTime date) {
    jobs.add(Job(name: name, notes: notes, date: date));
    notifyListeners();
  }
}
