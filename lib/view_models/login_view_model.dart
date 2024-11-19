import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_farm_iot/constants.dart';
import 'package:smart_farm_iot/main.dart';
import 'dart:convert';

class LoginViewModel with ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser(BuildContext context) async {
    final response = await http.post(
      Uri.parse('${Constants.url}/doan/login.php'),
      body: {
        'username': usernameController.text,
        'password': passwordController.text,
      },
    );

    final responseData = json.decode(response.body);
    if (responseData['status'] == 'success') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BottomNavScreen(userId: responseData['user_id'])),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(responseData['message'])),
      );
    }
  }
}
