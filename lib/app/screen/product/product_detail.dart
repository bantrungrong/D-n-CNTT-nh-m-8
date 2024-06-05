import 'dart:convert';

import 'package:drink_app_getx/app/core/values/strings.dart';
import 'package:drink_app_getx/app/screen/input_product/add_ticket_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../core/values/colors.dart';

class ProductDetail extends StatefulWidget {
  final String MaSanPham;
  final String TenSanPham;
  final String LoaiSanPham;
  final String DonGia;
  final String SoLuong;
  final String MaPhanXuong;
  final String TenPhanXuong;
  final String DiaChi;
  final String HinhAnh;
  const ProductDetail(
      {super.key,
      required this.DonGia,
      required this.LoaiSanPham,
      required this.MaSanPham,
      required this.SoLuong,
      required this.TenSanPham,
      required this.DiaChi,
      required this.MaPhanXuong,
      required this.TenPhanXuong,
      required this.HinhAnh});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  List<Map<String, dynamic>> factory = [];
  List<Map<String, dynamic>> inputTicket = [];
  @override
  void initState() {
    getRecord();
    getInputRecord();
    super.initState();
  }

  Future<void> getRecord() async {
    try {
      final response = await http.get(
          Uri.parse('http://192.168.195.206/practice_api/TT_xuong_sx.php'));
      if (response.statusCode == 200) {
        setState(() {
          factory = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        });
      } else {
        print('Failed to load product: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getInputRecord() async {
    try {
      final responseTT = await http.get(
          Uri.parse('http://192.168.195.206/practice_api/TT_phieu_nhap.php'));
      if (responseTT.statusCode == 200) {
        setState(() {
          inputTicket =
              List<Map<String, dynamic>>.from(jsonDecode(responseTT.body));
        });
      } else {
        print('Failed to load product: ${responseTT.statusCode}');
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
        toolbarHeight: 100 - 44,
        backgroundColor: AppColors.primary,
        title: _buildAppBar(),
      ),
      body: _buildBodyContext(),
    );
  }

  Widget _buildAppBar() {
    return Row(
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
                borderRadius: BorderRadius.circular(100), color: Colors.white),
            child: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: AppColors.primary,
            ),
          ),
        ),
        Text(
          'Thông tin chi tiết sản phẩm',
          style: AppStyle.bold(color: Colors.white, fontSize: 16),
        ),
        Container()
      ],
    );
  }

  Widget _buildBodyContext() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProduct(),
            _buildTitle(),
            Gap(8),
            Text(
              'Nhập hàng',
              style: AppStyle.bold(fontSize: 16).copyWith(color: Colors.red),
              overflow: TextOverflow.ellipsis,
            ),
            Gap(8),
            _buildInputTicket(),
          ],
        ));
  }

  Widget _buildProduct() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sản phẩm',
              style: AppStyle.bold(fontSize: 16).copyWith(color: Colors.red),
              overflow: TextOverflow.ellipsis,
            ),
            Gap(10),
            Text(
              'Mã SP: ${widget.MaSanPham}',
              style: AppStyle.medium(fontSize: 14)
                  .copyWith(fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
            Gap(8),
            Text(
              'Tên SP: ${widget.TenSanPham}',
              style: AppStyle.medium(fontSize: 14)
                  .copyWith(fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
            Gap(8),
            Text(
              'Loại SP: ${widget.LoaiSanPham}',
              style: AppStyle.medium(fontSize: 14)
                  .copyWith(fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
            Gap(8),
            Text(
              'Đơn giá: ${widget.DonGia}',
              style: AppStyle.medium(fontSize: 14)
                  .copyWith(fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Text(
                  'Trạng thái:',
                  style: AppStyle.regular(fontSize: 13),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    widget.SoLuong == '0' ? 'Hết hàng' : 'Còn hàng',
                    style: AppStyle.bold(
                        fontSize: 13,
                        color:
                            widget.SoLuong == '0' ? Colors.red : Colors.green),
                  ),
                ),
                widget.SoLuong != '0'
                    ? Text(
                        'Số lượng: ${widget.SoLuong}',
                        style: AppStyle.medium(fontSize: 14)
                            .copyWith(fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      )
                    : Text(''),
              ],
            ),
          ],
        ),
        // Container(
        //   height: 88,
        //   width: 88,
        //   child: Image.network('${widget.HinhAnh}'),
        // )
      ],
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phân xưởng sản xuất',
          style: AppStyle.bold(fontSize: 16).copyWith(color: Colors.red),
          overflow: TextOverflow.ellipsis,
        ),
        Gap(8),
        Text(
          'Mã phân xưởng: ${widget.MaPhanXuong}',
          style: AppStyle.medium(fontSize: 14)
              .copyWith(fontWeight: FontWeight.w500),
          overflow: TextOverflow.ellipsis,
        ),
        Gap(8),
        Text(
          'Tên phân xưởng: ${widget.TenPhanXuong}',
          style: AppStyle.medium(fontSize: 14)
              .copyWith(fontWeight: FontWeight.w500),
          overflow: TextOverflow.ellipsis,
        ),
        Gap(8),
        Text(
          'Địa chỉ phân xưởng: ${widget.DiaChi}',
          style: AppStyle.medium(fontSize: 14)
              .copyWith(fontWeight: FontWeight.w500),
          // overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildInputTicket() {
    bool hasMatchingTicket = false;

    for (var ticket in inputTicket) {
      if (widget.MaSanPham == ticket['MaSanPham']) {
        hasMatchingTicket = true;
        break;
      }
    }

    if (!hasMatchingTicket) {
      return Center(
        child: Column(
          children: [
            Gap(11),
            GestureDetector(
              onTap: () {
                Get.to(AddInput());
              },
              child: Icon(
                Icons.add_shopping_cart,
                color: Colors.red,
                size: 34,
              ),
            ),
            Gap(11),
            Text(
              'Không có phiếu nào',
              style: AppStyle.bold(color: Colors.red),
            ),
          ],
        ),
      );
    }

    return Column(
      children: inputTicket.map((ticket) {
        if (widget.MaSanPham == ticket['MaSanPham']) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(8),
              Text(
                'Mã Phiếu nhập: ${ticket['MaPhieuNhap']}',
                style: AppStyle.medium(fontSize: 14)
                    .copyWith(fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
              Gap(8),
              Text(
                'Tên phân xưởng: ${ticket['SoHieuXuong']}',
                style: AppStyle.medium(fontSize: 14)
                    .copyWith(fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
              Gap(8),
              Text(
                'Tên người giao: ${ticket['TenNguoiGiaoHang']}',
                style: AppStyle.medium(fontSize: 14)
                    .copyWith(fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
              Gap(8),
              Text(
                'Số lượng nhập: ${ticket['SoLuongNhap']}',
                style: AppStyle.medium(fontSize: 14)
                    .copyWith(fontWeight: FontWeight.w500),
                // overflow: TextOverflow.ellipsis,
              ),
              Gap(8),
              Text(
                'Tổng tiền: ${ticket['TongTien']}',
                style: AppStyle.medium(fontSize: 14)
                    .copyWith(fontWeight: FontWeight.w500),
                // overflow: TextOverflow.ellipsis,
              ),
              Gap(8),
              Container(
                height: 1,
                color: Colors.red,
              )
            ],
          );
        } else {
          return SizedBox.shrink();
        }
      }).toList(),
    );
  }
}
