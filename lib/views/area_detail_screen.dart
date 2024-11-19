import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm_iot/view_models/home_view_model.dart';
import 'package:smart_farm_iot/views/control_screen.dart';
import 'package:smart_farm_iot/views/employee_screen.dart';
import 'package:smart_farm_iot/views/job_screen.dart';
import 'package:smart_farm_iot/views/monitoring_screen.dart';

class AreaDetailScreen extends StatelessWidget {
  final int areaIndex;
  final String makhuvuc;
  final int userId;

  AreaDetailScreen({required this.areaIndex, required this.makhuvuc, required this.userId});

  @override
  Widget build(BuildContext context) {
    //final area = Provider.of<HomeViewModel>(context).areas[areaIndex];

    return Scaffold(
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight,
                decoration: const BoxDecoration(
                  color: Colors.yellow,
                ),
              ),

              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage("assets/imgs/top_bg.jpg"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(1),
                        BlendMode.dstATop,
                      ),
                    ),
                  ),
                ),
              ),

              Positioned( 
                top: 80, 
                left: 20, 
                child: Text( 
                  'Tên cây',
                  style: TextStyle( 
                    fontSize: 20, // Kích thước chữ lớn 
                    color: Colors.black, // Màu trắng cho dễ đọc trên nền tối 
                  ),
                ), 
              ),

              Positioned( 
                top: 110, 
                left: 20, 
                child: Text( 
                  'Tên khu vực',
                  style: TextStyle( 
                    fontSize: 35, // Kích thước chữ lớn 
                    fontWeight: FontWeight.bold, // Chữ in đậm 
                    color: Colors.black, // Màu trắng cho dễ đọc trên nền tối 
                  ),
                ), 
              ),

              Positioned(
                top: 180,
                left: 0,
                right: 0,
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                          child: Text("Bạn muốn làm gì?", style: TextStyle(fontSize: 30)),
                        ),
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                            children: [
                              _buildCard('Công Việc', Icons.work, () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => JobScreen(areaIndex: areaIndex, userId: userId, makhuvuc: makhuvuc),
                                  ),
                                );
                              }),
                              _buildCard('Điều Khiển', Icons.settings, () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => JobScreen(areaIndex: areaIndex, userId: userId, makhuvuc: makhuvuc),
                                  ),
                                );
                              }),
                              _buildCard('Giám Sát', Icons.visibility, () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MonitoringScreen(userId: userId, makhuvuc: makhuvuc),
                                  ),
                                );
                              }),
                              _buildCard('Nhân Viên', Icons.people, () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EmployeeScreen(userId: userId, makhuvuc: makhuvuc),
                                  ),
                                );
                              }),
                            ],
                          )
                        )
                      ],
                    )),
              ),
              Positioned( 
                top: 30, 
                left: 10, 
                child: IconButton( 
                  icon: Icon(Icons.arrow_back, color: Colors.white), 
                  onPressed: () { Navigator.pop(context); }, 
                ), 
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, IconData icon, [VoidCallback? onTap]) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder( 
          borderRadius: BorderRadius.circular(15.0), 
          side: BorderSide( 
            color: Colors.blue, // Màu của viền 
            width: 2.0, // Độ dày của viền 
          ), 
        ),

        color: Colors.white, // Màu nền của Card 
        child: Container( 
          width: 20, // Chiều rộng của Card 
          height: 20, // Chiều cao của Card 
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [ 
              Icon(icon, size: 40), 
              SizedBox(height: 10), 
              Text(title, style: TextStyle(fontSize: 20)), 
            ], 
          ), 
        ),
      ),
    );
  }
}