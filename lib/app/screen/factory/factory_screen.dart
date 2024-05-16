import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

import '../../core/values/colors.dart';
import '../../core/values/strings.dart';

class FactoryScreen extends StatefulWidget {
  const FactoryScreen({super.key});

  @override
  State<FactoryScreen> createState() => _FactoryScreenState();
}

class _FactoryScreenState extends State<FactoryScreen> {
  List<Map<String, dynamic>> factory = [];
  @override
  void initState() {
    super.initState();
    getRecord();
  }
  Future<void> getRecord() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.160.249/practice_api/factory_view.php'));
      if (response.statusCode == 200) {
        setState(() {
          factory = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        });
      } else {
        print('Failed to load factory: ${response.statusCode}');
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
            Text('Nhà sản xuất',style: AppStyle.bold(color: Colors.white),),
            IconButton(onPressed: (){}, icon: Icon(Icons.filter_alt_outlined,color: Colors.white,))
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: factory.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){

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
                    offset: const Offset(0, 2), // changes the direction of shadow
                  ),
                ],
              ),
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(Icons.account_tree_outlined,size: 18,),
                      SizedBox(width: 10,),
                      Text('Mã nhà sản xuất: ${factory[index]['MaNSX']}',overflow: TextOverflow.ellipsis,),
                    ],),
                    Row(children: [
                      Icon(Icons.account_tree_outlined,size: 18,),
                      SizedBox(width: 10,),
                      Container(width: Get.width*0.7,
                          child: Text('Tên nhà sản xuất: ${factory[index]['TenNSX']}',overflow: TextOverflow.ellipsis,)),
                    ],),
                    Row(children: [
                      Icon(Icons.account_tree_outlined,size: 18,),
                      SizedBox(width: 10,),
                      Container(
                          width: Get.width*0.7,
                          child: Text('Địa chỉ: ${factory[index]['DiaChi']}',overflow: TextOverflow.ellipsis,)),
                    ],),
                    Row(children: [
                      Icon(Icons.account_tree_outlined,size: 18,),
                      SizedBox(width: 10,),
                      Text('Số điện thoại: ${factory[index]['SoDienThoai']}',overflow: TextOverflow.ellipsis,),
                    ],),
                    // Row(children: [
                    //   Icon(Icons.account_tree_outlined,size: 18,),
                    //   SizedBox(width: 10,),
                    //   Container(
                    //       width: Get.width*0.6,
                    //       child: Text('Email: ${factory[index]['Email']}',overflow: TextOverflow.ellipsis,)),
                    // ],),

                    // Text('${factory[index]['DiaChi']}'),
                    // Text('${factory[index]['DiaChi']}'),
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
