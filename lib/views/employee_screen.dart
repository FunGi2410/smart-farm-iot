import 'package:flutter/material.dart';
import 'package:smart_farm_iot/models/area.dart';

class EmployeeScreen extends StatefulWidget {
  final Area area;

  EmployeeScreen({required this.area});

  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return Scaffold(
      appBar: AppBar(title: Text('Nhân Viên - ${widget.area.nameArea}')),
      body: ListView.builder(
        itemCount: widget.area.employees.length,
        itemBuilder: (context, index) {
          final employee = widget.area.employees[index];
          final isToday = employee.date.year == today.year &&
              employee.date.month == today.month &&
              employee.date.day == today.day;

          return Card(
            child: ListTile(
              title: Text(employee.name),
              subtitle: Text('${employee.date.toString()}'),
              trailing: isToday
                  ? Switch(
                      value: employee.isPresent,
                      onChanged: (value) {
                        setState(() {
                          employee.isPresent = value;
                        });
                      },
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}
