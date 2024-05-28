import 'dart:convert';
import 'package:drink_app_getx/app/core/values/strings.dart';
import 'package:drink_app_getx/app/screen/shop/shop_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../core/values/colors.dart';
import 'package:get/get.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    getRecord();
  }

  Future<void> getRecord() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.1.12/practice_api/TT_daily.php'));
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
            Text(
              'Đại lý',
              style: AppStyle.bold(color: Colors.white),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.filter_alt_outlined,
                  color: Colors.white,
                ))
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(Shopdetail(
                idShop: index,
              ));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.account_tree_outlined,
                          size: 18,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Mã đại lý ${users[index]['MaDaiLy']}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.account_tree_outlined,
                          size: 18,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Tên đại lý: ${users[index]['TenDaiLy']}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.account_tree_outlined,
                          size: 18,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            width: Get.width * 0.7,
                            child: Text(
                              'Địa chỉ: ${users[index]['DiaChi']}',
                              overflow: TextOverflow.ellipsis,
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.account_tree_outlined,
                          size: 18,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Số điện thoại: ${users[index]['DienThoai']}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.account_tree_outlined,
                          size: 18,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            width: Get.width * 0.6,
                            child: Text(
                              'Số tiền nợ: ${users[index]['SoTienNo']}',
                              overflow: TextOverflow.ellipsis,
                            )),
                      ],
                    ),
                  ],
                ),
                subtitle: Text(''),
              ),
            ),
          );
        },
      ),
    );
  }
}
