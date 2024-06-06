import 'dart:convert';

import 'package:drink_app_getx/app/core/values/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

class ChatBox extends StatefulWidget {
  final String me;
  final String you;
  const ChatBox({super.key, required this.me, required this.you});

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  final TextEditingController mess = TextEditingController();
  Future<void> insertRecord() async {
    try {
      String uri = "http://192.168.195.206/practice_api/add_tinnhan.php";
      var res = await http.post(Uri.parse(uri), body: {
        "TenDangNhap": widget.me,
        "NoiDung": mess.text,
      });
      var reponse = jsonDecode(res.body);
      if (reponse["success"] == "true") {
        // Fluttertoast.showToast(msg: 'Thêm thành công');
      } else {
        print("some issue");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [Text('${widget.you}')],
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: Get.height * 0.855,
            width: Get.width * 0.9,
            color: Colors.red,
          ),
          Container(
            // color: Colors.blue,
            child: _buildTextField('title', mess),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String title, TextEditingController name) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Icon(Icons.abc),
        SizedBox(
          width: Get.width * 0.7,
          child: TextField(
            controller: name,
            maxLines: 1,
            decoration: const InputDecoration(
              errorStyle: TextStyle(height: 0),
              contentPadding: EdgeInsets.all(10),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        TextButton(
            onPressed: () {
              insertRecord();
            },
            child: Text('Gửi'))
      ],
    );
  }
}
