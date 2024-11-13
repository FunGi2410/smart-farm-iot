import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:smart_farm_iot/views/auth/login_screen.dart';

class RegisterViewModel with ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<void> registerUser(BuildContext context) async {
    final response = await http.post(
      Uri.parse('http://192.168.5.101/doan/register.php'),
      body: {
        'username': usernameController.text,
        'password': passwordController.text,
        'email': emailController.text,
      },
    );

    final responseData = json.decode(response.body);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(responseData['message'])),
    );
    if (responseData['status'] == 'success') {
      Navigator.pop(context);
    }
  }

  // Future<void> registerUser(BuildContext context) async {
  //   if (usernameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Vui lòng điền đầy đủ thông tin')));
  //     return;
  //   }

  //   final response = await http.post(
  //     Uri.parse('http://192.168.5.101/doan/register.php'),
  //     body: {
  //       'username': usernameController.text,
  //       'password': passwordController.text,
  //       'email': emailController.text,
  //     },
  //   );

  //   print("Register Response Status Code: ${response.statusCode}");
  //   print("Register Response Body: ${response.body}");

  //   var data = json.decode(response.body);
  //   if (data['status'] == 'success') {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Đăng ký thành công')));
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => LoginScreen()),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data['message'])));
  //   }
  // }
}
