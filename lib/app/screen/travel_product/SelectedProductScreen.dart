import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import '../../core/values/colors.dart';
import '../../core/values/strings.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SelectedProductScreen extends StatefulWidget {
  final String idTicket;
  final String idShop;
  const SelectedProductScreen(
      {super.key, required this.idShop, required this.idTicket});

  @override
  State<SelectedProductScreen> createState() => _SelectedProductScreenState();
}

class _SelectedProductScreenState extends State<SelectedProductScreen> {
  TextEditingController count = TextEditingController();
  @override
  void initState() {
    super.initState();
    getRecord();
  }

  List<Map<String, dynamic>> users = [];
  Future<void> getRecord() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.1.2/practice_api/view_data.php'));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 100 - 44,
          backgroundColor: AppColors.primary,
          title: Row(
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
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          height: Get.height * 0.9,
          width: Get.width * 1,
          child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(
                              0, 2), // changes the direction of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Mã SP: ${users[index]['MaSanPham']}',
                                  style: AppStyle.medium(fontSize: 14)
                                      .copyWith(fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Tên SP: ${users[index]['TenSanPham']}',
                                  style: AppStyle.medium(fontSize: 14)
                                      .copyWith(fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Loại SP: ${users[index]['LoaiSanPham']}',
                                  style: AppStyle.medium(fontSize: 14)
                                      .copyWith(fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Đơn giá: ${users[index]['DonGia']}',
                                  style: AppStyle.medium(fontSize: 14)
                                      .copyWith(fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Số lượng: ${users[index]['SoLuongTon']}',
                                  style: AppStyle.medium(fontSize: 14)
                                      .copyWith(fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Trạng thái:',
                                      style: AppStyle.regular(fontSize: 13),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        users[index]['SoLuongTon'] == '0'
                                            ? 'Hết hàng'
                                            : 'Còn hàng',
                                        style: AppStyle.regular(
                                            fontSize: 13,
                                            color: users[index]['SoLuongTon'] ==
                                                    '0'
                                                ? Colors.red
                                                : Colors.green),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: Get.height * 0.4,
                                      width: Get.width * 1,
                                      child: Column(
                                        children: List.generate(
                                            5, (index) => Text('data')),
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.add),
                            ),
                          ),
                        ),
                      ],
                    ));
              }),
        ));
  }

  Widget _buildTextField(String title, TextEditingController name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyle.medium(
            fontSize: 16,
          ),
        ),
        const Gap(8),
        Container(
          height: 55,
          width: 55,
          child: TextField(
            controller: name,
            maxLines: 1,
            decoration: const InputDecoration(
              errorStyle: TextStyle(height: 0),
              contentPadding: EdgeInsets.all(10),
              border: OutlineInputBorder(),
            ),
          ),
        )
      ],
    );
  }
}
