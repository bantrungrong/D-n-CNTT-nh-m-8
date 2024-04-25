

import 'dart:convert';

import 'package:drink_app_getx/app/core/values/icons.dart';
import 'package:drink_app_getx/app/screen/shop/shop.dart';
import 'package:drink_app_getx/app/screen/shop/shop_controller.dart';
import 'package:drink_app_getx/app/travel_product/travel_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import '../../core/values/strings.dart';
import '../../data/data_base_helper.dart';
import '../event_screen/event_screen.dart';
import '../product/product.dart';
class HomePageScreenLogined extends StatefulWidget {

  const HomePageScreenLogined({super.key});

  @override
  State<HomePageScreenLogined> createState() => _HomePageScreenLoginedState();
}

class _HomePageScreenLoginedState extends State<HomePageScreenLogined> {



  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;

    // Extract the arguments
    final arg1 = arguments['arg1'];
    final arg2 = arguments['arg2'];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: Get.height * 0.1,
        backgroundColor: Colors.red,
        title: Row(children: [
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                ),
                const Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  //   Text(
                  // users[1]['uname'],
                  //     style: AppStyle.bold(fontSize: 15, color: Colors.white),
                  //   ),
                    Text('Tên người dùng: $arg1',style: AppStyle.bold(fontSize: 13, color: Colors.white),),
                    Text('Công ty : $arg2',style: AppStyle.bold(fontSize: 15, color: Colors.white),),
                    // Text(
                    //   'Tên: $args',
                    //   style: AppStyle.bold(fontSize: 15, color: Colors.white),
                    // ),
                    // Text(
                    //   'Công ty nước giải khát X',
                    //   style: AppStyle.bold(fontSize: 13, color: Colors.white),
                    // ),
                  ],
                )
              ],
            ),
          ),
        ]),
      ),
      body: _buildBodyContent(),

    );
  }

  Widget _buildBodyContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Text(
            'Danh mục',
            style: AppStyle.bold(
              fontSize: 18,
            ),
          ),
        ),
        Center(
          child: Wrap(
            spacing: 20,
            runSpacing: 10,
            children: [
              GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, ProductScreen() );
                    Get.to(const ProductScreen());
                  }, child: _buildCell('Quản lý danh mục sản phẩm',MyIcon.product)),
              GestureDetector(
                onTap: (){
                  Get.to(UserListScreen());
                },
                  child: _buildCell('Quản lý thông tin đại lý',MyIcon.shop)),
              GestureDetector(
                onTap: (){
                  Get.to(LoginPage());
                },
                  child: _buildCell('Quản lý xuất hàng',MyIcon.travel)),
              _buildCell('Quản lý nhập hàng',MyIcon.take),
              _buildCell('Thống kê báo cáo',MyIcon.detail),
              _buildCell('Xưởng sản xuất',MyIcon.factory),

            ],
          ),
        )
      ],
    );
  }

  Widget _buildCell(String data,String icon) {
    return Container(
      height: Get.width/3-20,
      width: Get.width/3 -20,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 2), // changes the direction of shadow
          ),
        ],
      ),
      child: Column(children: [
        Container(
          height: 23,
          width: 23,
          decoration: BoxDecoration(
            color: Colors.red,
              image: DecorationImage(
                  image: AssetImage(icon)
              )
          ),
        ),
        Gap(5),
        Text(
          data,
          style: AppStyle.bold(fontSize: 12, color: Colors.red),
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }
}
