
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm_iot/view_models/home_view_model.dart';
import 'package:smart_farm_iot/views/control_screen.dart';
import 'package:smart_farm_iot/views/employee_screen.dart';
import 'package:smart_farm_iot/views/job_screen.dart';
import 'package:smart_farm_iot/views/monitoring_screen.dart';

class AreaDetailScreen extends StatelessWidget {
  final int areaIndex;
  AreaDetailScreen({required this.areaIndex});

  @override
  Widget build(BuildContext context) {
    final area = Provider.of<HomeViewModel>(context).areas[areaIndex];
    
    return Scaffold(
      appBar: AppBar(
        title: Text(area.nameArea),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildCard('Công Việc', Icons.work, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => JobScreen(areaIndex: areaIndex),
              ),
            );
          }),
          _buildCard('Điều Khiển', Icons.settings, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ControlScreen(area: area),
              ),
            );
          }),
          _buildCard('Giám Sát', Icons.visibility, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MonitoringScreen(area: area),
              ),
            );
          }),
          _buildCard('Nhân Viên', Icons.people, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EmployeeScreen(area: area),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCard(String title, IconData icon, [VoidCallback? onTap]) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}