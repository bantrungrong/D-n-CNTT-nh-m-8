import 'dart:convert';
import 'dart:async';
import 'package:drink_app_getx/app/core/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class MessageScreen extends StatefulWidget {
  final String name;
  final String avatar;
  final String tier;

  const MessageScreen({
    Key? key,
    required this.name,
    required this.avatar,
    required this.tier,
  }) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController mess = TextEditingController();
  List<Map<String, dynamic>> users = [];
  Timer? _timer;
  final ScrollController _scrollController = ScrollController();

  static const String getMessagesUrl =
      'http://192.168.195.206/practice_api/TT_tinnhan.php';
  static const String addMessageUrl =
      'http://192.168.195.206/practice_api/add_tinnhan.php';

  @override
  void initState() {
    super.initState();
    getRecord();
    // Refresh dữ liệu mỗi 5 giây
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      getRecord();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> getRecord() async {
    try {
      final response = await http.get(Uri.parse(getMessagesUrl));
      if (response.statusCode == 200) {
        setState(() {
          users = List<Map<String, dynamic>>.from(jsonDecode(response.body));
          // Cuộn xuống dưới cùng khi nhận được tin nhắn mới
          _scrollToBottom();
        });
      } else {
        debugPrint('Không tải được người dùng: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Lỗi: $e');
    }
  }

  Future<void> insertRecord() async {
    try {
      var res = await http.post(Uri.parse(addMessageUrl), body: {
        "TenDangNhap": widget.name,
        "NoiDung": mess.text,
      });
      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        Fluttertoast.showToast(msg: 'Gửi tin nhắn thành công');
        mess.clear();
        getRecord();
      } else {
        debugPrint("Có vấn đề xảy ra");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Truyền thông nội bộ'),
        actions: [
          IconButton(
            onPressed: () {
              getRecord();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment:
                          widget.name == users[index]['TenDangNhap']
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                      children: [
                        if (widget.name == users[index]['TenDangNhap'])
                          Container(
                            width: Get.width * 0.78,
                            padding: EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('${users[index]['NoiDung']}'),
                              ],
                            ),
                          ),
                        Gap(12),
                        Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                color:
                                    widget.name == users[index]['TenDangNhap']
                                        ? Colors.blue
                                        : Colors.red),
                          ),
                          child: Center(
                            child: Text(
                              '${users[index]['TenDangNhap']}',
                              overflow: TextOverflow.ellipsis,
                              style: AppStyle.bold(
                                  color:
                                      widget.name == users[index]['TenDangNhap']
                                          ? Colors.blue
                                          : Colors.red,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                        Gap(12),
                        if (widget.name != users[index]['TenDangNhap'])
                          Container(
                            width: Get.width * 0.7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${users[index]['NoiDung']}'),
                              ],
                            ),
                          ),
                      ],
                    ),
                    Gap(12),
                  ],
                );
              },
            ),
          ),
          Container(
            height: 55,
            child: _buildTextField(mess),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.message),
        Expanded(
          child: TextField(
            controller: controller,
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
          child: Text('Gửi'),
        ),
      ],
    );
  }
}
