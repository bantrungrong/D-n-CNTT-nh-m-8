import 'dart:convert';

import 'package:drink_app_getx/app/core/values/colors.dart';
import 'package:drink_app_getx/app/core/values/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

class DetailInput extends StatefulWidget {
  final String MaPhieuNhap;
  final String MaSanPham;
  final String SoHieuXuong;
  final String TenNguoiGiaoHang;
  final String TenSanPham;
  final String DonGia;
  final String SoLuongNhap;
  final String ThanhTien;
  final String TongTien;
  final String ChuKyViet;
  final String ChuKyNhan;
  final String ChuKyTruongDonVi;

  const DetailInput(
      {super.key,
      required this.ChuKyNhan,
      required this.ChuKyTruongDonVi,
      required this.ChuKyViet,
      required this.DonGia,
      required this.MaPhieuNhap,
      required this.MaSanPham,
      required this.SoHieuXuong,
      required this.SoLuongNhap,
      required this.TenNguoiGiaoHang,
      required this.TenSanPham,
      required this.ThanhTien,
      required this.TongTien});
  @override
  State<DetailInput> createState() => _DetailInputState();
}

class _DetailInputState extends State<DetailInput> {
  @override
  void initState() {
    super.initState();
    getRecord();
  }

  List<Map<String, dynamic>> ticket = [];
  Future<void> getRecord() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.1.5/practice_api/practice_api/TT_chitietPhieuXuat.php'));
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
    if (widget.MaPhieuNhap == null) {
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
    return ListView(
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red)),
            child: Column(
              children: [
                Container(
                  child: Text(
                    'Thông tin phiếu nhập',
                    style: AppStyle.bold(color: Colors.red),
                  ),
                ),
                Gap(8),
                _buildCell('Mã phiếu nhập', widget.MaPhieuNhap),
                _buildCell('Số hiệu xưởng', widget.SoHieuXuong),
                _buildCell('Tên người giao hàng', widget.TenNguoiGiaoHang),
                _buildCell('Chữ ký viết', widget.ChuKyViet),
                _buildCell('Chữ ký nhận', widget.ChuKyNhan),
                _buildCell('Chữ ký trưởng đơn vị', widget.ChuKyTruongDonVi),
                Text(
                  'Sản phẩm',
                  style: AppStyle.bold(color: Colors.red),
                ),
                Gap(8),
                _buildCell('Mã sản phẩm', widget.MaSanPham),
                _buildCell('Tên sản phẩm', widget.TenSanPham),
                _buildCell('Đơn giá', widget.DonGia),
                _buildCell('Số lượng nhập', widget.SoLuongNhap),
                _buildCell('Thành tiền', widget.ThanhTien),
                _buildCell('Tổng tiền', widget.TongTien),
              ],
            ),
          ),
        ),
      ],
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
