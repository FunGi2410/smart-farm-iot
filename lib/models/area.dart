import 'package:smart_farm_iot/models/job.dart';

class Area {
  final int id;
  final String nameArea;
  final String namePlant;
  final String img;
  List<Job> jobs = [];

  Area({required this.id, required this.nameArea, required this.namePlant, required this.img});
}