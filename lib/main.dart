import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm_iot/view_models/employee_view_model.dart';
import 'package:smart_farm_iot/view_models/job_view_model.dart';
import 'package:smart_farm_iot/view_models/login_view_model.dart';
import 'package:smart_farm_iot/view_models/register_view_model.dart';
import 'package:smart_farm_iot/views/auth/login_screen.dart';
import 'package:smart_farm_iot/views/auth/register_screen.dart';
import 'view_models/home_view_model.dart';
import 'views/home_screen.dart';
import 'views/inventory_screen.dart';
import 'package:device_preview/device_preview.dart';

// void main() {
//   runApp(MyApp());
// }

void main() => runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(), // Wrap your app
  ),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
        ChangeNotifierProvider(create: (context) => JobViewModel()),
        ChangeNotifierProvider(create: (context) => EmployeeViewModel()),
        ChangeNotifierProvider(create: (context) => RegisterViewModel()),
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
      ],
      child: MaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        // initialRoute: '/',
        // routes: {
        //   '/': (context) => LoginScreen(),
        //   '../views/auth/register_screen.dart': (context) => RegisterScreen(),
        //   '../main.dart': (context) => BottomNavScreen(),
        // },
        home: LoginScreen(),
      )
    );
  }
}

class BottomNavScreen extends StatefulWidget {
  final int userId; 
  BottomNavScreen({required this.userId});
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  
  int _selectedIndex = 0;

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(userId: widget.userId),
      InventoryScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], 
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Inventory',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,  
        onTap: _onItemTapped,            
      ),
    );
  }
}
