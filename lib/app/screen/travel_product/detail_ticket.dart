import 'dart:convert';

import 'package:drink_app_getx/app/core/values/colors.dart';
import 'package:drink_app_getx/app/core/values/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

class DetailTicket extends StatefulWidget {
  final String idTicketInfor;
  final String idShopInfor;
  final String nameInfor;
  final String dateInfor;

  final String writeInfor;
  final String wireTakeInfor;
  final String writeManagerInfor;
  final String dateImportInfor;
  final String numberInfor;

  const DetailTicket(
      {super.key,
      required this.dateInfor,
      required this.idShopInfor,
      required this.idTicketInfor,
      required this.nameInfor,
      required this.dateImportInfor,
      required this.numberInfor,
      required this.wireTakeInfor,
      required this.writeInfor,
      required this.writeManagerInfor});
  @override
  State<DetailTicket> createState() => _DetailTicketState();
}

class _DetailTicketState extends State<DetailTicket> {
  @override
  void initState() {
    super.initState();
    getRecord();
  }

  List<Map<String, dynamic>> ticket = [];
  Future<void> getRecord() async {
    try {
      final response = await http.get(
          Uri.parse('http://192.168.1.2/practice_api/TT_chitietPhieuXuat.php'));
      if (response.statusCode == 200) {
        setState(() {
          ticket = List<Map<String, dynamic>>.from(jsonDecode(response.body));
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
    if (widget.idShopInfor == null) {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      );
    }
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
      body: _buildContext(),
    );
  }

  Widget _buildContext() {
    return Center(
      child: Container(
        width: Get.width * 0.9,
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.red)),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Thông tin phiếu xuất',
                style: AppStyle.bold(color: Colors.red),
              ),
            ),
            _buildCell('Mã phiếu xuất', widget.idTicketInfor),
            _buildCell('Mã đại lý', widget.idShopInfor),
            _buildCell('Tên người nhận', widget.nameInfor),
            _buildCell('Ngày xuất', widget.dateInfor),
            _buildCell('Chữ ký viết', widget.writeInfor),
            _buildCell('Chữ ký nhận', widget.wireTakeInfor),
            _buildCell('Chữ ký trưởng đơn vị', widget.writeManagerInfor),
            _buildCell('Ngày cấp', widget.dateImportInfor),
            _buildCell('Số giấy chứng nhận', widget.numberInfor),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Sản phẩm',
                style: AppStyle.bold(color: Colors.red),
              ),
            ),
            Container(
              height: Get.height * 0.6,
              width: Get.width * 0.9,
              child: ListView.builder(
                  itemCount: ticket.length,
                  itemBuilder: (context, index) {
                    return ticket[index]['MaDaiLy'] == widget.idShopInfor
                        ? Column(
                            children: [
                              _buildCell('Mã sản phẩm xuất',
                                  '${ticket[index]['MaSanPham']}'),
                              _buildCell('Số lượng xuất',
                                  '${ticket[index]['SoLuongXuat']}'),
                              _buildCell(
                                  'Đơn giá', '${ticket[index]['TongTien']}'),
                              Gap(12),
                            ],
                          )
                        : Container();
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCell(String leftText, String rightText) {
    return Container(
      width: Get.width * 0.95,
      margin: EdgeInsets.symmetric(
        horizontal: 12,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: Get.width * 0.4,
                child: Text(
                  leftText,
                  style: AppStyle.medium(),
                ),
              ),
              Container(
                width: Get.width * 0.4,
                child: Text(
                  rightText,
                  style: AppStyle.medium(),
                ),
              ),
            ],
          ),
          Container(
            height: 0.1,
            margin: EdgeInsets.symmetric(vertical: 12),
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
