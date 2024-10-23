import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_farm_iot/view_models/home_view_model.dart';

class JobScreen extends StatelessWidget {
  final int areaIndex;

  JobScreen({required this.areaIndex});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);
    final area = viewModel.areas[areaIndex];
    return Scaffold(
      appBar: AppBar(title: Text('Công Việc')),
      body: ListView.builder(
        itemCount: area.jobs.length,
        itemBuilder: (context, index) {
          final job = area.jobs[index];
          return Card(
            child: ListTile(
              title: Text(job.name),
              subtitle: Text('${job.notes} - ${job.date.toString()}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddJobDialog(context, viewModel, areaIndex);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddJobDialog(BuildContext context, HomeViewModel viewModel, int areaIndex) {
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
                viewModel.addJobToArea(
                  areaIndex,
                  nameController.text,
                  notesController.text,
                  selectedDate,
                );
                Navigator.of(context).pop();
              },
              child: Text('Lưu'),
            ),
          ],
        );
      },
    );
  }
}
