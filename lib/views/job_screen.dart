import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm_iot/view_models/home_view_model.dart';
import 'package:smart_farm_iot/view_models/job_view_model.dart';

class JobScreen extends StatelessWidget {
  final int areaIndex;
  final String makhuvuc;
  final int userId;

  JobScreen({required this.areaIndex, required this.makhuvuc, required this.userId});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<JobViewModel>(context);
    //final area = viewModel.areas[areaIndex];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddJobDialog(context, viewModel);
        },
        child: Icon(Icons.add),
      ),

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
                  'Tên cây - Tên khu vực',
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
                  'Công việc',
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
                          child: FutureBuilder<List<dynamic>>(
                            future: viewModel.getTask(userId, makhuvuc),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return Center(child: Text('Không có công việc nào.'));
                              } else {
                                return ListView.builder(
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    var task = snapshot.data![index];
                                    return Card(
                                      child: ListTile(
                                        title: Text(task['congviec'] ?? 'Chưa có tên công việc'),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(task['ghichu'] ?? 'Chưa có ghi chú'),
                                            Text(
                                              task['thoigian'],
                                            ),
                                          ],
                                        ),
                                        leading: 
                                          Image.network("https://cdn-icons-png.flaticon.com/512/2098/2098402.png"),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.delete),
                                              onPressed: () => viewModel.removeTask(task['id'], context),
                                            ),
                                          ],
                                        ),
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

  void _showAddJobDialog(BuildContext context, JobViewModel viewModel) {
    final nameController = TextEditingController();
    final notesController = TextEditingController();
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Thêm Công Việc'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Tên Công Việc'),
              ),
              TextField(
                controller: notesController,
                decoration: InputDecoration(labelText: 'Ghi Chú'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) {
                    selectedDate = date;
                  }
                },
                child: Text('Chọn Ngày'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                viewModel.addTask(
                  nameController.text,
                  notesController.text,
                  selectedDate,
                  userId,
                  makhuvuc,
                  context
                );
                //Navigator.of(context).pop();
              },
              child: Text('Lưu'),
            ),
          ],
        );
      },
    );
  }
}
