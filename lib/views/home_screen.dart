import 'package:flutter/material.dart';
import '../view_models/home_view_model.dart';
import 'package:provider/provider.dart';
import 'area_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  final int userId; 
  HomeScreen({required this.userId});

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

      //appBar: AppBar(title: Text('Home')),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage("assets/imgs/top_bg.jpg"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5),
                      BlendMode.dstATop,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 160,
                left: 0,
                right: 0,
                child: Container(
                    height: 600,
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
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Tìm kiếm...',
                              hintStyle:
                                  const TextStyle(color: Color(0xFFCFCACA)),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.8),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(90),
                                borderSide: const BorderSide(
                                  color: Color(0xFFCFCACA),
                                  width: 1.0,
                                ),
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Color(0xFFCFCACA),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: FutureBuilder(
                            future: viewModel.getDataArea(userId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData ||
                                  (snapshot.data as List).isEmpty) {
                                return Center(child: Text('Unavailable data'));
                              } 
                              else{
                                var data = snapshot.data as List;
                                return ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    final area = data[index];
                                    return Card(
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "assets/imgs/top_bg.jpg",
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.contain,
                                          ),
                                          SizedBox(width: 10.0),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                area['tenkhuvuc'],
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                area['tencaytrong'],
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCard(String regionName, String treeName, String imagePath) {
    return Card(
      margin: EdgeInsets.all(10.0),
      elevation: 5.0,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  regionName,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  treeName,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAddAreaDialog(BuildContext context, HomeViewModel viewModel) {
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
                  userId.toString(),
                );
                // viewModel.addAreaToDatabase(
                //   tenKhuVucController.text,
                //   loaiCayTrongController.text,
                // );
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
