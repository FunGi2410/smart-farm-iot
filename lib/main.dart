import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm_iot/view_models/job_view_model.dart';
import 'package:smart_farm_iot/view_models/login_view_model.dart';
import 'package:smart_farm_iot/view_models/register_view_model.dart';
import 'package:smart_farm_iot/views/auth/login_screen.dart';
import 'package:smart_farm_iot/views/auth/register_screen.dart';
import 'view_models/home_view_model.dart';
import 'views/home_screen.dart';
import 'views/inventory_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeViewModel()),
        //ChangeNotifierProvider(create: (context) => JobViewModel()),
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => RegisterViewModel()),
      ],
      child: MaterialApp(
        // initialRoute: '/',
        // routes: {
        //   '/': (context) => LoginScreen(),
        //   '../views/auth/register_screen.dart': (context) => RegisterScreen(),
        //   '../main.dart': (context) => BottomNavScreen(),
        // },
        home: BottomNavScreen(),
      )
    );
  }
}

class BottomNavScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    InventoryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Smart Farm'),
      // ),
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
