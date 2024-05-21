import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
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
          .get(Uri.parse('http://192.168.1.2/practice_api/TT_thong_ke.php'));
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
          .get(Uri.parse('http://192.168.1.2/practice_api/view_data.php'));
      if (responseProduct.statusCode == 200) {
        setState(() {
          product =
              List<Map<String, dynamic>>.from(jsonDecode(responseProduct.body));
        });
      } else {
        print('Failed to load users: ${responseProduct.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Báo cáo thống kê'),
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
                            if (value.toInt() >= 0 &&
                                value.toInt() < product.length + 1) {
                              return value.truncate().toString();
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
                        (index) => BarChartGroupData(
                          x: index + 1,
                          barRods: [
                            BarChartRodData(
                              y: double.parse(product[index]['SoLuongTon']),
                              colors: [Colors.blue],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: Get.height * 0.6,
                  child: ListView.builder(itemBuilder: (context, index) {
                    return Column(
                      children: [],
                    );
                  }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
