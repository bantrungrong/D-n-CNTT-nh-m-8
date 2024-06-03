import 'dart:convert';

import 'package:drink_app_getx/app/widget/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../core/values/colors.dart';
import '../../core/values/strings.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class FactoryAdd extends StatefulWidget {
  final String MaPhanXuong;
  final String TenPhanXuong;
  final String DiaChi;
  final String MaSanPham;
  const FactoryAdd(
      {super.key,
      required this.DiaChi,
      required this.MaPhanXuong,
      required this.TenPhanXuong,
      required this.MaSanPham});

  @override
  State<FactoryAdd> createState() => _FactoryAddState();
}

class _FactoryAddState extends State<FactoryAdd> {
  final TextEditingController TenPhanXuong = TextEditingController();
  final TextEditingController DiaChi = TextEditingController();
  final TextEditingController MaSanPham = TextEditingController();

  List<Map<String, dynamic>> users = [];

  Future<void> getRecord() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.1.5/practice_api/TT_xuong_sx.php'));
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

  Future<void> updateFactory() async {
    if (TenPhanXuong.text.isEmpty || DiaChi.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Vui lòng nhập đầy đủ thông tin');
      return;
    }
    try {
      String uri = "http://192.168.1.5/practice_api/update_xuong_san_xuat.php";
      var res = await http.post(Uri.parse(uri), body: {
        "TenPhanXuong": TenPhanXuong.text,
        "DiaChi": DiaChi.text,
        "MaPhanXuong": widget.MaPhanXuong,
      });
      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        Fluttertoast.showToast(msg: 'Sửa thành công');
        getRecord(); // Refresh the data
      } else {
        print("some issue");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> delFactory(String MaPhanXuong) async {
    try {
      String uri = "http://192.168.1.5/practice_api/delete_factory.php";
      var res = await http.post(Uri.parse(uri), body: {
        "MaPhanXuong": MaPhanXuong,
      });
      var responseDel = jsonDecode(res.body);
      if (responseDel['success'] == 'true') {
        print('record delete complete');
        getRecord(); // Refresh the data
      } else {
        print('some issue');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getRecord();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.MaPhanXuong == null) {
      return const Center(
          child: CircularProgressIndicator(
        color: Colors.red,
      ));
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100 - 44,
        backgroundColor: AppColors.primary,
        title: _buildAppBar(),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mã phân xưởng: ${widget.MaPhanXuong}',
                  style: AppStyle.medium(),
                ),
                const Gap(12),
                _buildTextField(
                    'Tên phân xưởng: ${widget.TenPhanXuong}', TenPhanXuong),
                const Gap(10),
                _buildTextField('Địa chỉ: ${widget.DiaChi}', DiaChi),
                const Gap(23),
                GestureDetector(
                  onTap: () {
                    if (TenPhanXuong.text.isEmpty || DiaChi.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: 'Vui lòng nhập đầy đủ thông tin');
                      return;
                    }
                    updateFactory();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const ButtonApp(
                        height: 55,
                        width: 200,
                        title: 'Xác nhận lưu',
                        color: Colors.white,
                        colorTitle: Colors.red,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            padding: const EdgeInsets.only(left: 7),
            height: 36,
            width: 36,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100), color: Colors.white),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: AppColors.primary,
            ),
          ),
        ),
        Text(
          'Sửa thông tin xưởng sản xuất',
          style: AppStyle.bold(color: Colors.white, fontSize: 16),
        ),
        GestureDetector(
          onTap: () {
            delFactory(widget.MaPhanXuong);
            Get.back();
          },
          child: Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100), color: Colors.white),
            child: const Icon(
              Icons.delete,
              color: AppColors.primary,
              size: 22,
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
          style: AppStyle.medium(fontSize: 16),
        ),
        const Gap(8),
        SizedBox(
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
      ],
    );
  }
}
