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

      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: MediaQuery.of(context).size.height - kBottomNavigationBarHeight - 36,
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
                top: 110, 
                left: 10, 
                child: Text( 
                  'Quản lý khu vực',
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
                                    return _buildCard(index, area, viewModel, context);
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

  Widget _buildCard(int index, final area, HomeViewModel viewModel, BuildContext context) {
    return Card( 
      child: ListTile( 
        title: Text(area['tenkhuvuc']), 
        subtitle: Text(area['tencaytrong']), 
        leading: 
          Image.network("https://cdn.pixabay.com/photo/2016/10/30/18/01/apple-1783882_640.png"),
        trailing: IconButton( 
          icon: Icon(Icons.delete), 
          onPressed: () { 
            viewModel.removeArea(area['makhuvuc'], context); 
          }, 
        ), 
        onTap: () { 
          Navigator.push( 
            context, 
            MaterialPageRoute( 
              builder: (context) => AreaDetailScreen(areaIndex: index,makhuvuc: area['makhuvuc'], userId: userId), 
            ), 
          ); 
        }, 
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
