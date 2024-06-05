import 'dart:convert';
import 'package:drink_app_getx/app/core/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class ReportScreenSell extends StatefulWidget {
  const ReportScreenSell({Key? key}) : super(key: key);

  @override
  State<ReportScreenSell> createState() => _ReportScreenSellState();
}

class _ReportScreenSellState extends State<ReportScreenSell> {
  List<Map<String, dynamic>> report = [];
  List<Map<String, dynamic>> product = [];

  @override
  void initState() {
    super.initState();
    getRecord();
    getRecordProduct();
  }

  Future<void> getRecord() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.30.249/practice_api/TT_thong_ke.php'));
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

  Future<void> getRecordProduct() async {
    try {
      final responseProduct = await http
          .get(Uri.parse('http://192.168.30.249/practice_api/view_data.php'));
      if (responseProduct.statusCode == 200) {
        setState(() {
          product =
              List<Map<String, dynamic>>.from(jsonDecode(responseProduct.body));
        });
        // Debug print the product data
        print('Product Data: $product');
      } else {
        print('Failed to load products: ${responseProduct.statusCode}');
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
            'Thống kê số lượng tồn',
            style: AppStyle.bold(color: Colors.white),
          ),
          Container()
        ]),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              children: [
                Expanded(
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY:
                          10000, // You can adjust the maximum value accordingly
                      barTouchData: BarTouchData(enabled: false),
                      titlesData: FlTitlesData(
                        bottomTitles: SideTitles(
                          showTitles: true,
                          getTextStyles: (context, value) => const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          margin: 20,
                          getTitles: (double value) {
                            // Display product names as x-axis labels
                            int index = value.toInt() - 1;
                            if (index >= 0 && index < product.length) {
                              return '${index + 1}' ?? '';
                            }
                            return '';
                          },
                        ),
                        leftTitles: SideTitles(
                          showTitles: true,
                          getTextStyles: (context, value) => const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          margin: 20,
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                      ),
                      barGroups: List.generate(
                        product.length,
                        (index) {
                          // Handle null values safely
                          double yValue = double.tryParse(
                                  product[index]['SoLuongTon']?.toString() ??
                                      '0') ??
                              0;
                          return BarChartGroupData(
                            x: index + 1,
                            barRods: [
                              BarChartRodData(
                                y: yValue,
                                colors: [Colors.blue],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: Get.height * 0.3,
            child: ListView.builder(
                itemCount: product.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${index + 1}: ${product[index]['TenSanPham'] ?? 'Unknown Product'}',
                              style: AppStyle.medium(fontSize: 13),
                            ),
                            Text(
                              '${product[index]['SoLuongTon'] ?? 'Unknown Product'}',
                              style: AppStyle.medium(fontSize: 13),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
