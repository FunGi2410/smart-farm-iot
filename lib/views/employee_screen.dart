import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm_iot/models/area.dart';
import 'package:smart_farm_iot/view_models/employee_view_model.dart';

class EmployeeScreen extends StatelessWidget {
  final String makhuvuc;
  final int userId;

  EmployeeScreen({required this.userId, required this.makhuvuc});
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EmployeeViewModel>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //_showAddAreaDialog(context, viewModel);
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
                  'Nhân viên',
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
                            future: viewModel.getEmployee(userId, makhuvuc),
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
                                    final employee = data[index];
                                    return _buildCard(employee);
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


    // return Scaffold(
    //   appBar: AppBar(title: Text('Nhân Viên - ${widget.area.nameArea}')),
    //   body: ListView.builder(
    //     itemCount: widget.area.employees.length,
    //     itemBuilder: (context, index) {
    //       final employee = widget.area.employees[index];
    //       final isToday = employee.date.year == today.year &&
    //           employee.date.month == today.month &&
    //           employee.date.day == today.day;

    //       return Card(
    //         child: ListTile(
    //           title: Text(employee.name),
    //           subtitle: Text('${employee.date.toString()}'),
    //           trailing: isToday
    //               ? Switch(
    //                   value: employee.isPresent,
    //                   onChanged: (value) {
    //                     setState(() {
    //                       employee.isPresent = value;
    //                     });
    //                   },
    //                 )
    //               : null,
    //         ),
    //       );
    //     },
    //   ),
    // );
  }

  Widget _buildCard(final employee){
    return Card(
      child: ListTile(
        leading: 
          Image.network("https://cdn1.iconfinder.com/data/icons/avatar-3/512/Manager-512.png"),
        title: Text(employee['name']),
        subtitle: Text('Quản lý'),
        // trailing: isToday
        //     ? Switch(
        //         value: employee.isPresent,
        //         onChanged: (value) {
        //           setState(() {
        //             employee.isPresent = value;
        //           });
        //         },
        //       )
        //     : null,
      ),
    );
  }
}
