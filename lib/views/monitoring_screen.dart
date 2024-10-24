import 'package:flutter/material.dart';
import 'package:smart_farm_iot/models/area.dart';

class MonitoringScreen extends StatelessWidget {
  final Area area;

  MonitoringScreen({required this.area});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Giám Sát - ${area.nameArea}')),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildCard('Nhiệt độ', '25°C', Icons.thermostat),
          _buildCard('Độ ẩm', '60%', Icons.water),
          _buildCard('Ánh sáng', '800 lx', Icons.wb_sunny),
          _buildCard('Độ ẩm đất', '30%', Icons.park),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String value, IconData icon) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40),
          SizedBox(height: 10),
          Text(title, style: TextStyle(fontSize: 20)),
          SizedBox(height: 10),
          Text(value, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
