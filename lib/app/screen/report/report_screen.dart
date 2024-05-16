import 'package:flutter/material.dart';

import '../../core/values/colors.dart';
import '../../core/values/strings.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

import 'chart_output.dart';
class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
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
            Text('Báo cáo thống kê',style: AppStyle.bold(color: Colors.white),),
            IconButton(onPressed: (){}, icon: Icon(Icons.filter_alt_outlined,color: Colors.white,))
          ],
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22,vertical: 12),
            child: Text('Thống kê trong tháng',style: AppStyle.bold(),),
          ),
          Center(
            child: Wrap(
              spacing: 20,
              runSpacing: 10,
              children: [
                _buildCell('Sản phẩm xuất'),
                _buildCell('Tiền xuất'),
                _buildCell('Sản phẩm nhập'),
                _buildCell('Tiền nhập'),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22,vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Biểu đồ tổng hợp',style: AppStyle.bold(),),
                Gap(11),
                GestureDetector(
                  onTap: (){
                    Get.to(PieChartSample());
                  },
                  child: Container(
                    height: 55,
                    width: Get.width*0.4,
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
                    child: Center(child: Text('Biểu đồ xuất'),),
                  ),
                )
              ],
            ),
          ),

        ],
      )
    );
  }
  Widget _buildCell(String data) {
    return Container(
      height: Get.width*0.3,
      width: Get.width*0.4,
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 22),
              child: Text(
                        data,
                        style: AppStyle.bold(fontSize: 12, color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
            ),
      ]),
    );
  }
}
