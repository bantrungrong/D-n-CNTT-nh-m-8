import 'dart:convert';

import 'package:drink_app_getx/app/core/values/colors.dart';
import 'package:drink_app_getx/app/core/values/strings.dart';
import 'package:drink_app_getx/app/screen/travel_product/SelectedProductScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    getRecord();
  }

  List<Map<String, dynamic>> ticket = [];
  Future<void> getRecord() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.30.249/practice_api/TT_chitietPhieuXuat.php'));
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

  Future<void> _handleRefresh() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.30.249/practice_api/TT_chitietPhieuXuat.php'));

      if (response.statusCode == 200) {
        setState(() {
          ticket = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        });
      } else {
        print('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      // Complete the refresh indicator
      _refreshController.refreshCompleted();
    }
  }

  Future<void> delIdProduct(String MaSanPham) async {
    print('$MaSanPham');
    try {
      String uri = "http://192.168.30.249/practice_api/delete_phieuxuat.php";
      var res = await http.post(Uri.parse(uri), body: {
        "MaSanPham": '$MaSanPham',
      });
      var responseDel = jsonDecode(res.body);
      if (responseDel['success'] == 'true') {
        print('record delete complete');
        getRecord(); // Refresh the data
      } else {
        print('some issue');
      }
    } catch (e) {
      print(e);
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
            Text(
              'Chi tiết phiếu xuất',
              style: AppStyle.bold(color: Colors.white),
            ),
            Container()
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sản phẩm',
                    style: AppStyle.bold(color: Colors.red),
                  ),
                  IconButton(
                      onPressed: () {
                        Get.to(SelectedProductScreen(
                          writeManager: widget.writeManagerInfor,
                          dateExport: widget.dateInfor,
                          idShop: widget.idShopInfor,
                          idTicket: widget.idTicketInfor,
                          nameTake: widget.nameInfor,
                          dateImport: widget.dateImportInfor,
                          numberNote: widget.numberInfor,
                          writeTake: widget.wireTakeInfor,
                          write: widget.writeInfor,
                        ));
                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
            Container(
              height: Get.height * 0.6,
              width: Get.width * 0.9,
              child: SmartRefresher(
                controller: _refreshController,
                onRefresh: _handleRefresh,
                child: ListView.builder(
                    itemCount: ticket.length,
                    itemBuilder: (context, index) {
                      return ticket[index]['MaDaiLy'] == widget.idShopInfor
                          ? Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(6),
                                    padding: EdgeInsets.only(top: 12),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Column(
                                      children: [
                                        _buildCell('Mã sản phẩm xuất',
                                            '${ticket[index]['MaSanPham']}'),
                                        _buildCell('Số lượng xuất',
                                            '${ticket[index]['SoLuongXuat']}'),
                                        _buildCell('Đơn giá',
                                            '${ticket[index]['DonGia']}'),
                                        _buildCell('Thành tiền',
                                            '${ticket[index]['TongTien']}'),
                                        Gap(12),
                                      ],
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      delIdProduct(ticket[index]['MaSanPham']);
                                    },
                                    icon: Icon(Icons.delete))
                              ],
                            )
                          : Container();
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCell(String leftText, String rightText) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                leftText,
                style: AppStyle.medium(),
              ),
              Text(
                rightText,
                style: AppStyle.medium(),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Container(
            height: 0.5,
            margin: EdgeInsets.symmetric(vertical: 12),
            color: Colors.red,
          )
        ],
      ),
    );
  }
}
