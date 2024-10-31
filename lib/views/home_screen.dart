import 'package:flutter/material.dart';
import '../view_models/home_view_model.dart';
import 'package:provider/provider.dart';
import 'area_detail_screen.dart';

class HomeScreen extends StatelessWidget {
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

      appBar: AppBar(title: Text('Home')),
      body: FutureBuilder(
        future: viewModel.getDataArea(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return Center(child: Text('Unavailable data'));
          } else{
            var data = snapshot.data as List;
            return ListView.builder(
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
                            viewModel.removeArea(index, data);
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
            );
          }
        },
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
                  // select img
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
                viewModel.addAreaToDatabase(
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
