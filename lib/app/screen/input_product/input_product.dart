import 'dart:convert';

import 'package:drink_app_getx/app/screen/input_product/add_ticket_input.dart';
import 'package:drink_app_getx/app/screen/input_product/detail_ticket_input.dart';
import 'package:drink_app_getx/app/screen/travel_product/detail_ticket.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../core/values/colors.dart';
import '../../core/values/strings.dart';
import '../../widget/button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class TicketInput extends StatefulWidget {
  const TicketInput({super.key});

  @override
  State<TicketInput> createState() => _TicketInputState();
}

class _TicketInputState extends State<TicketInput> {
  List<Map<String, dynamic>> ticket = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    getRecordTTPhieuXuat();
  }

  Future<void> getRecordTTPhieuXuat() async {
    try {
      final responseTT = await http.get(
          Uri.parse('http://192.168.203.241/practice_api/TT_phieu_nhap.php'));
      if (responseTT.statusCode == 200) {
        setState(() {
          ticket = List<Map<String, dynamic>>.from(jsonDecode(responseTT.body));
        });
      } else {
        print('Failed to load users: ${responseTT.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _handleRefresh() async {
    try {
      final response = await http.get(
          Uri.parse('http://192.168.203.241/practice_api/TT_phieu_nhap.php'));

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
            Text(
              'Phiếu nhập hàng',
              style: AppStyle.bold(color: Colors.white),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.apps,
                  color: Colors.white,
                ))
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () {
          Get.to(AddInput());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: ButtonApp(
              height: 55,
              width: Get.width * 0.7,
              title: '+ Thêm phiếu xuất',
              color: Colors.white,
              colorTitle: Colors.red),
        ),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _handleRefresh,
        child: ListView.builder(
            itemCount: ticket.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
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
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(DetailInput(
                                  ChuKyNhan: ticket[index]['ChuKyNhan'],
                                  ChuKyTruongDonVi: ticket[index]
                                      ['ChuKyTruongDonVi'],
                                  ChuKyViet: ticket[index]['ChuKyViet'],
                                  DonGia: ticket[index]['DonGia'],
                                  MaPhieuNhap: ticket[index]['MaPhieuNhap'],
                                  MaSanPham: ticket[index]['MaSanPham'],
                                  SoHieuXuong: ticket[index]['SoHieuXuong'],
                                  SoLuongNhap: ticket[index]['SoLuongNhap'],
                                  TenNguoiGiaoHang: ticket[index]
                                      ['TenNguoiGiaoHang'],
                                  TenSanPham: ticket[index]['TenSanPham'],
                                  ThanhTien: ticket[index]['ThanhTien'],
                                  TongTien: ticket[index]['TongTien']));
                            },
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Mã phiếu nhập: ${ticket[index]['MaPhieuNhap']}',
                                    style: AppStyle.medium(fontSize: 14)
                                        .copyWith(fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Mã sản phẩm: ${ticket[index]['MaSanPham']}',
                                    style: AppStyle.medium(fontSize: 14)
                                        .copyWith(fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Số hiệu xưởng nhập: ${ticket[index]['SoHieuXuong']}',
                                    style: AppStyle.medium(fontSize: 14)
                                        .copyWith(fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Sản phẩm nhập: ${ticket[index]['TenSanPham']}',
                                    style: AppStyle.medium(fontSize: 14)
                                        .copyWith(fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Số lượng nhập: ${ticket[index]['SoLuongNhap']}',
                                    style: AppStyle.medium(fontSize: 14)
                                        .copyWith(fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              );
            }),
      ),
    );
  }
}
