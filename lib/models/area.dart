import 'package:smart_farm_iot/models/device.dart';
import 'package:smart_farm_iot/models/employee.dart';
import 'package:smart_farm_iot/models/job.dart';

class Area {
  final int id;
  final String nameArea;
  final String namePlant;
  final String img;
  List<Job> jobs = [];
  List<Device> devices;
  List<Employee> employees;

  Area({
    required this.id, 
    required this.nameArea, 
    required this.namePlant, 
    required this.img, 
    this.devices = const [],
    this.employees = const [],
  });
}