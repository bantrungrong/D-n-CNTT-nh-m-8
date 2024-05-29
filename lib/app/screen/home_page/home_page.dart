import 'package:flutter/material.dart';

import '../../core/values/icons.dart';
import '../../core/values/strings.dart';
import 'package:get/get.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildBodyContent(),
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
            spacing: 10,
            runSpacing: 10,
            children: [
              _buildCell('Quản lý danh mục sản phẩm', MyIcon.product),
              _buildCell('Quản lý thông tin đại lý', MyIcon.shop),
              _buildCell('Quản lý xuất hàng', MyIcon.travel),
              _buildCell('Quản lý nhập hàng', MyIcon.take),
              _buildCell('Thống kê báo cáo', MyIcon.detail),
              _buildCell('Xưởng sản xuất', MyIcon.factory),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildCell(String data, String icon) {
    return Container(
      height: Get.width / 3 - 20,
      width: Get.width / 3 - 20,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
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
              image: DecorationImage(image: AssetImage(icon))),
        ),
        Text(
          data,
          style: AppStyle.bold(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }
}
