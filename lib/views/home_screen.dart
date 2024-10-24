import 'package:flutter/material.dart';
import 'package:smart_farm_iot/services/auth_service.dart';
import 'package:smart_farm_iot/views/auth/login_screen.dart';
import '../view_models/home_view_model.dart';
import 'package:provider/provider.dart';
import 'area_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddAreaDialog(context, viewModel);
        },
        child: Icon(Icons.add),
      ),

      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _authService.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),

      body: _authService.isLoggedIn()
        ?ListView.builder(
          itemCount: viewModel.areas.length,
          itemBuilder: (context, index) {
            final area = viewModel.areas[index];
            return Card(
              child: Column(  
                mainAxisSize: MainAxisSize.min,  
                children: <Widget>[  
                    ListTile(  
                    leading: Icon(Icons.album, size: 45),  
                    title: Text(area.nameArea),  
                    subtitle: Text(area.namePlant), 
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        viewModel.removeArea(index);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AreaDetailScreen(areaIndex: index),
                        ),
                      );
                    }, 
                  ),  
                ],  
              ),  
            );
          },
        )
        : Center(
            child: CircularProgressIndicator(),
          ),
    );
  }

  void _showAddAreaDialog(BuildContext context, HomeViewModel viewModel){
    final tenKhuVucController = TextEditingController();
    final loaiCayTrongController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thêm khu vực'),
          content: Column(
            children: [
              TextField(
                controller: tenKhuVucController,
                decoration: InputDecoration(labelText: 'Tên Khu Vực'),
              ),
              TextField(
                controller: loaiCayTrongController,
                decoration: InputDecoration(labelText: 'Loại Cây Trồng'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // logic để chọn ảnh từ thư viện và lấy URL
                  // imageUrl = ...
                },
                child: Text('Chọn Ảnh'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                viewModel.addArea(
                  tenKhuVucController.text,
                  loaiCayTrongController.text,
                );
                Navigator.pop(context);
              },
              child: Text('Thêm'),
            )
          ],
        );
      },
    );
  }
}
