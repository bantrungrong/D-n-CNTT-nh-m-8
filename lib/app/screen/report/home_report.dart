// import 'dart:convert';
// import 'dart:html';

import 'dart:convert';

import 'package:drink_app_getx/app/core/values/strings.dart';
import 'package:drink_app_getx/app/screen/report/report_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class HomeReport extends StatefulWidget {
  const HomeReport({super.key});

  @override
  State<HomeReport> createState() => _HomeReportState();
}

class _HomeReportState extends State<HomeReport> {
  List<Map<String, dynamic>> report = [];
  List<Map<String, dynamic>> product = [];
  bool toggle = true;
  @override
  void initState() {
    getRecord();
    getRecordP();
    super.initState();
  }

  Future<void> getRecord() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.1.5/practice_api/TT_bao_cao.php'));
      if (response.statusCode == 200) {
        setState(() {
          report = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        });
      } else {
        print('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getRecordP() async {
    try {
      final responseP = await http
          .get(Uri.parse('http://192.168.1.5/practice_api/view_data.php'));
      if (responseP.statusCode == 200) {
        setState(() {
          product = List<Map<String, dynamic>>.from(jsonDecode(responseP.body));
        });
      } else {
        print('Failed to load users: ${responseP.statusCode}');
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
        toolbarHeight: Get.height * 0.1,
        backgroundColor: Colors.red,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          Text(
            'Báo cáo thống kê',
            style: AppStyle.bold(color: Colors.white),
          ),
          Container()
        ]),
      ),
      body: _buildBodyContext(),
    );
  }

  Widget _buildBodyContext() {
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            'Thống kê đã xuất',
            style: AppStyle.bold(),
          ),
        ),
        _buildReport(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            'Thống kê sản phẩm tồn kho',
            style: AppStyle.bold(),
          ),
        ),
        _buildProductItem(),
      ],
    );
  }

  Widget _buildProductItem() {
    return GestureDetector(
      onTap: () {
        Get.to(ReportScreen());
      },
      child: Container(
        margin: EdgeInsets.all(33),
        padding: EdgeInsets.all(33),
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
        child: Center(
          child: Text(
            'Xem biểu đồ thống kê',
            style: AppStyle.bold(color: Colors.red),
          ),
        ),
      ),
    );
  }

  Widget _buildReport() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: List.generate(
            report.length,
            (index) => Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    Icon(
                      Icons.circle,
                      color: Colors.red,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(12),
                        padding: EdgeInsets.all(12),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tháng ${report[index]['Thang']}-${report[index]['Nam']}',
                              style: AppStyle.bold(
                                  color: Colors.red, fontSize: 13),
                            ),
                            SizedBox(
                              height: 22,
                            ),
                            Text(
                              '${report[index]['SoLuongXuat']}',
                              style: AppStyle.bold(color: Colors.blue),
                            ),
                            Text(
                              '${report[index]['DoanhThu']}',
                              style: AppStyle.bold(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
      ),
    );
  }

  Widget _buildCell(String title, String valueReport, Color color) {
    return Container(
      margin: EdgeInsets.all(12),
      padding: EdgeInsets.all(12),
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
          Text(
            title,
            style: AppStyle.bold(color: Colors.red),
          ),
          SizedBox(
            height: 22,
          ),
          Text(
            valueReport,
            style: AppStyle.bold(color: color),
          ),
        ],
      ),
    );
  }
}
