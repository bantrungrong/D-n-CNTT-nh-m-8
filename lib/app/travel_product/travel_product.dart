import 'dart:convert';

import 'package:drink_app_getx/app/screen/home_page/home_page_logined.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String message = '';

  Future<void> login() async {
    final response = await http.post(
      Uri.parse('http://192.168.1.5/practice_api/login_data.php'),
      body: {
        'uname': usernameController.text,
        'password': passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);

      for (var user in responseData) {
        if (user['uname'] == usernameController.text &&
            user['upassword'] == passwordController.text) {
          // Đăng nhập thành công, chuyển sang màn hình khác
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePageScreenLogined()),
          );
          return;
        }
      }

      // Nếu không tìm thấy tên người dùng và mật khẩu trong dữ liệu trả về
      setState(() {
        message = 'Tên người dùng hoặc mật khẩu không đúng';
      });
    } else {
      setState(() {
        message = 'Error: ${response.statusCode}';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng nhập'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Tên người dùng'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Mật khẩu'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: Text('Đăng nhập'),
            ),
            SizedBox(height: 10),
            Text(
              message,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   final String username;
//
//   HomeScreen({required this.username});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chào mừng $username'),
//       ),
//       body: Center(
//         child: Text('Chào mừng $username!'),
//       ),
//     );
//   }
// }
