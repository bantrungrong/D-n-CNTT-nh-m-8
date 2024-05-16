import 'dart:convert';

import 'package:flutter/material.dart';

import '../../core/values/colors.dart';
import '../../core/values/strings.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Shopdetail extends StatefulWidget {
  const Shopdetail({super.key});

  @override
  State<Shopdetail> createState() => _ShopdetailState();
}

class _ShopdetailState extends State<Shopdetail> {
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    getRecord();
  }

  Future<void> getRecord() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.46/practice_api/TT_daily.php'));
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
    final value = Get.arguments as int;
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
            Text('Thông tin đại lý',style: AppStyle.bold(color: Colors.white),),
            IconButton(onPressed: (){}, icon: Icon(Icons.filter_alt_outlined,color: Colors.white,))
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12)
        ),
        child: ListView(
          children: [
            _buildCell('Mã đại lý', '${users[value]['MaDaiLy']}'),
            _buildCell('Tên đại lý', '${users[value]['TenDaiLy']}'),
            _buildCell('Địa chỉ', '${users[value]['DiaChi']}'),
            _buildCell('Số điện thoại', '${users[value]['SoDienThoai']}'),
            _buildCell('email', '${users[value]['Email']}'),
          ],
        ),
      ),
    );
  }
  Widget _buildCell(String title,String infor ){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,style: AppStyle.regular(),),
              Text(infor,style: AppStyle.regular(),),
            ],
          ),
          SizedBox(height: 10,),
          Container(height: 0.1,width: Get.width*0.9,color: Colors.black,)
        ],
      ),
    );
  }
}
