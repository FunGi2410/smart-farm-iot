import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:smart_farm_iot/views/home_screen.dart';

class LoginViewModel with ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser(BuildContext context) async {
    final response = await http.post(
      Uri.parse('http://192.168.5.101/doan/login.php'),
      body: {
        'username': usernameController.text,
        'password': passwordController.text,
      },
    );

    final responseData = json.decode(response.body);
    if (responseData['status'] == 'success') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(userId: responseData['user_id'])),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(responseData['message'])),
      );
    }
  }

//   Future<void> loginUser(BuildContext context) async {
//     final response = await http.post(
//       Uri.parse('http://192.168.5.101/doan/login.php'),
//       body: {
//         'username': usernameController.text,
//         'password': passwordController.text,
//       },
//     );
//     print("Login Response Status Code: ${response.statusCode}");
//     print("Login Response Body: ${response.body}");
//     var data = json.decode(response.body);
//     if (data['status'] == 'success') {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HomeScreen(userName: usernameController.text)),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data['message'])));
//     }
//   }
}
