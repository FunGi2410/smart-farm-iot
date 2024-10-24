import 'package:flutter/material.dart';

class DeviceStateManager {
  static final DeviceStateManager _instance = DeviceStateManager._internal();

  factory DeviceStateManager() {
    return _instance;
  }

  DeviceStateManager._internal();

  final Map<String, bool> _deviceStates = {};
  final Map<String, TimeOfDay?> _deviceTimes = {};

  void setDeviceState(String areaName, bool state, TimeOfDay? time) {
    _deviceStates[areaName] = state;
    _deviceTimes[areaName] = time;
  }

  bool getDeviceState(String areaName) {
    return _deviceStates[areaName] ?? false;
  }

  TimeOfDay? getDeviceTime(String areaName) {
    return _deviceTimes[areaName];
  }
}
