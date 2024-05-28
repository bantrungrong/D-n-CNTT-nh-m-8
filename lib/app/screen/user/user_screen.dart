import 'dart:convert';

import 'package:drink_app_getx/app/core/values/strings.dart';
import 'package:drink_app_getx/app/modules/home/home_view.dart';
import 'package:drink_app_getx/app/widget/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class UserService {
  final box = GetStorage();

  void clearUserData() {
    box.erase();
  }
}

class UserScreen extends StatefulWidget {
  final String idUser;
  final String nameCom;
  final String tier;
  final String PasWord;
  final String email;
  final String avatar;
  final String country;
  const UserScreen(
      {super.key,
      required this.idUser,
      required this.nameCom,
      required this.tier,
      required this.PasWord,
      required this.email,
      required this.avatar,
      required this.country});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final UserService _userService = UserService();
  final TextEditingController oldPass = TextEditingController();
  final TextEditingController newPass = TextEditingController();
  final TextEditingController rePass = TextEditingController();
  @override
  void initState() {
    super.initState();
    getRecord();
  }

  void _handleLogout() {
    _userService.clearUserData();
    Get.offAll(HomePage());
  }

  List<Map<String, dynamic>> user = [];
  Future<void> getRecord() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.1.12/practice_api/login_data.php'));
      if (response.statusCode == 200) {
        setState(() {
          user = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        });
      } else {
        print('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> updatePass() async {
    if (oldPass.text.isEmpty || newPass.text.isEmpty || rePass.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Vui lòng nhập đầy đủ thông tin');
      return;
    } else if (oldPass.text.isEmpty != rePass.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Mật khẩu nhập lại không đúng');
    }
    try {
      String uri = "http://192.168.1.12/practice_api/update_user.php";
      var res = await http.post(Uri.parse(uri), body: {
        "MatKhau": rePass.text,
        "TenDangNhap": widget.idUser,
      });
      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        Fluttertoast.showToast(msg: 'Sửa thành công');
        Navigator.pop(context);
        // getRecord(); // Refresh the data
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
      body: _buildBodyContext(),
    );
  }

  Widget _buildBodyContext() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: Get.height * 0.1,
              width: Get.width * 1,
              color: Colors.red,
            ),
            Container(
              // height: Get.height * 0.2,
              width: Get.width * 0.9,
              margin: EdgeInsets.only(top: Get.height * 0.05),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset:
                        const Offset(0, 2), // changes the direction of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 88,
                        width: 88,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Image.network('${widget.avatar}'),
                      ),
                      Gap(12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tên Tài khoản: ${widget.idUser}',
                            style: AppStyle.bold(),
                          ),
                          Container(
                            width: Get.width * 0.4,
                            child: Column(
                              children: [
                                Text(
                                  'Tên công ty: ${widget.nameCom}',
                                  style: AppStyle.medium(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Chức vụ:',
                          style: AppStyle.bold(),
                        ),
                        Text(
                          '${widget.tier}',
                          style: AppStyle.bold(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: Get.width * 0.9,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 2), // changes the direction of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.grey.shade50,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 55,
                                ),
                                Text(
                                  'Thông tin tài khoản',
                                  style: AppStyle.bold(
                                      fontSize: 18, color: Colors.red),
                                ),
                                Gap(22),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(Icons.close),
                                )
                              ],
                            ),
                            insetPadding: const EdgeInsets.all(12),
                            content: Container(
                              width: Get.width * 1,
                              height: Get.height * 0.4,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 66,
                                      width: 66,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Image.network('${widget.avatar}'),
                                    ),
                                    Gap(12),
                                    _buildCell('Tên tài khoản', widget.idUser),
                                    _buildCell('Tên công ty', widget.nameCom),
                                    _buildCell('Chức vụ công ty', widget.tier),
                                    _buildCell('Email cá nhân', widget.email),
                                    _buildCell('Địa chỉ', widget.country),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.account_circle,
                            color: Colors.red,
                          ),
                          Gap(12),
                          Text(
                            'Thông tin tài khoản',
                            style: AppStyle.bold(),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
                Gap(24),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.grey.shade50,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Đổi mật khẩu',
                                  style: AppStyle.bold(
                                      fontSize: 18, color: Colors.red),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(Icons.close),
                                )
                              ],
                            ),
                            insetPadding: const EdgeInsets.all(6),
                            content: Container(
                              width: Get.width * 1,
                              height: Get.height * 0.42,
                              child: ListView(
                                children: [
                                  _buildTextField('Mật khẩu cũ', oldPass),
                                  Gap(10),
                                  _buildTextField('Mật khẩu mới', newPass),
                                  Gap(10),
                                  _buildTextField(
                                      'nhập lại mật khẩu mới', rePass),
                                  Gap(20),
                                  GestureDetector(
                                    onTap: () {
                                      if (oldPass.text != widget.PasWord) {
                                        Fluttertoast.showToast(
                                            msg: 'Mật khẩu cũ không đúng');
                                      } else if (oldPass.text != '' &&
                                          newPass.text != '' &&
                                          rePass.text != '' &&
                                          oldPass.text == widget.PasWord &&
                                          rePass.text == newPass.text) {
                                        updatePass();
                                      } else
                                        Fluttertoast.showToast(
                                            msg: 'Kiểm tra lại mật khẩu');
                                    },
                                    child: ButtonApp(
                                        height: 55,
                                        width: Get.width * 0.4,
                                        title: 'Xác nhận đổi',
                                        color: Colors.white,
                                        colorTitle: Colors.red),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.lock,
                            color: Colors.red,
                          ),
                          Gap(12),
                          Text(
                            'Đổi mật khẩu',
                            style: AppStyle.bold(),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
                Gap(24),
                GestureDetector(
                  onTap: () {
                    _handleLogout();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.red,
                          ),
                          Gap(12),
                          Text(
                            'Đăng xuất',
                            style: AppStyle.bold(),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String title, TextEditingController name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyle.medium(
            fontSize: 14,
          ),
        ),
        const Gap(8),
        SizedBox(
          width: MediaQuery.of(context).size.height,
          child: TextFormField(
            controller: name,
            readOnly: false,
            maxLines: 1,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              errorStyle: TextStyle(height: 0),
              contentPadding: EdgeInsets.all(10),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildCell(String title, String infor) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppStyle.regular(fontSize: 13),
              ),
              Container(
                width: Get.width * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      infor,
                      style: AppStyle.medium(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap(12),
          Container(
            height: 1,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
