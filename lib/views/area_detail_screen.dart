
import 'package:flutter/material.dart';
import 'package:smart_farm_iot/models/area.dart';

class AreaDetailScreen extends StatelessWidget {
  final Area area;

  AreaDetailScreen({required this.area});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(area.nameArea),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildCard('Công Việc', Icons.work),
          _buildCard('Điều Khiển', Icons.settings),
          _buildCard('Giám Sát', Icons.visibility),
          _buildCard('Nhân Viên', Icons.people),
        ],
      ),
    );
  }

  Widget _buildCard(String title, IconData icon) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40),
          SizedBox(height: 10),
          Text(title, style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}