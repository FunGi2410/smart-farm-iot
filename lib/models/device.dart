import 'package:flutter/material.dart';

class Device {
  String name;
  bool isOn;
  TimeOfDay? time;

  Device({required this.name, this.isOn = false, this.time});
}
