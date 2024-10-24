import 'package:flutter/material.dart';
import 'package:smart_farm_iot/models/area.dart';
import 'package:smart_farm_iot/models/device.dart';
import 'package:smart_farm_iot/view_models/device_state_manager.dart';

class ControlScreen extends StatefulWidget {
  final Area area;

  ControlScreen({required this.area});

  @override
  _ControlScreenState createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  bool deviceOn = false;
  TimeOfDay? selectedTime;

  void initState() {
    super.initState();
    _loadDeviceStates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Điều Khiển - ${widget.area.nameArea}')),
      body: ListView.builder(
        itemCount: widget.area.devices.length,
        itemBuilder: (context, index) {
          final device = widget.area.devices[index];
          return Column(
            children: [
              ListTile(
                title: Text(device.name),
                trailing: Switch(
                  value: device.isOn,
                  onChanged: (value) {
                    setState(() {
                      device.isOn = value;
                      if (device.isOn) {
                        _selectTime(context, device);
                      } else {
                        device.time = null;
                        _saveDeviceState(device);
                      }
                    });
                  },
                ),
              ),
              if (device.isOn && device.time != null)
                Text('${device.name} sẽ bật vào lúc ${device.time!.format(context)}'),
            ],
          );
        },
      ),
    );
  }

  void _loadDeviceStates() {
    for (var device in widget.area.devices) {
      device.isOn = DeviceStateManager().getDeviceState('${widget.area.nameArea}_${device.name}');
      device.time = DeviceStateManager().getDeviceTime('${widget.area.nameArea}_${device.name}');
    }
    setState(() {});
  }

  void _saveDeviceState(Device device) {
    DeviceStateManager().setDeviceState('${widget.area.nameArea}_${device.name}', device.isOn, device.time);
  }

  Future<void> _selectTime(BuildContext context, Device device) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != device.time) {
      setState(() {
        device.time = picked;
        _saveDeviceState(device);
      });
    }
  }
}
