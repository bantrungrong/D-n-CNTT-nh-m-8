import 'dart:convert';

import 'package:drink_app_getx/app/core/values/strings.dart';
import 'package:drink_app_getx/app/screen/message_screen/chat_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class MessageScreen extends StatefulWidget {
  final String name;
  final String avatar;
  final String tier;
  const MessageScreen(
      {super.key,
      required this.name,
      required this.avatar,
      required this.tier});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController mess = TextEditingController();
  List<Map<String, dynamic>> users = [];
  @override
  void initState() {
    super.initState();
    getRecord();
  }

  Future<void> getRecord() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.195.206/practice_api/TT_tinnhan.php'));
      if (response.statusCode == 200) {
        setState(() {
          users = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        });
      } else {
        print('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> insertRecord() async {
    try {
      String uri = "http://192.168.195.206/practice_api/add_tinnhan.php";
      var res = await http.post(Uri.parse(uri), body: {
        "TenDangNhap": widget.name,
        "NoiDung": mess.text,
      });
      var reponse = jsonDecode(res.body);
      if (reponse["success"] == "true") {
        Fluttertoast.showToast(msg: 'Gửi tin nhắn thành công');
        getRecord();
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
        title: Text('Truyền thông nội bộ'),
      ),
      body: ListView(
        children: [
          Container(
            height: Get.height * 0.8,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: List.generate(
                    users.length,
                    (index) => Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                                  widget.name == users[index]['TenDangNhap']
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                              children: [
                                widget.name == users[index]['TenDangNhap']
                                    ? Text('${users[index]['NoiDung']}')
                                    : Text(''),
                                Gap(12),
                                Container(
                                  height: 55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(color: Colors.blue)),
                                  child: Center(
                                      child: Text(
                                          '${users[index]['TenDangNhap']}')),
                                ),
                                Gap(12),
                                widget.name == users[index]['TenDangNhap']
                                    ? Text('')
                                    : Text('${users[index]['NoiDung']}'),
                              ],
                            ),
                            Gap(12),
                          ],
                        )),
              ),
            ),
          ),
          Container(
            height: 55,
            child: _buildTextField('title', mess),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String title, TextEditingController name) {
    return ListView(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.abc),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
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
            ),
            TextButton(
                onPressed: () {
                  insertRecord();
                },
                child: Text('Gửi'))
          ],
        ),
      ],
    );
  }
}
