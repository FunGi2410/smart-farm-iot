
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm_iot/view_models/home_view_model.dart';
import 'package:smart_farm_iot/views/job_screen.dart';

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
          _buildCard('Điều Khiển', Icons.settings),
          _buildCard('Giám Sát', Icons.visibility),
          _buildCard('Nhân Viên', Icons.people),
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