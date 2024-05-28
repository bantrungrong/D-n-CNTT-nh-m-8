import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/values/colors.dart';
import '../../core/values/strings.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Shopdetail extends StatefulWidget {
  final int idShop;
  const Shopdetail({super.key, required this.idShop});

  @override
  State<Shopdetail> createState() => _ShopdetailState();
}

class _ShopdetailState extends State<Shopdetail> {
  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> shop = [];
  List<Map<String, dynamic>> ticket = [];
  List<Map<String, dynamic>> product = [];

  @override
  void initState() {
    super.initState();
    getRecord();
    getRecordSanPham();
    getRecordChiTietPhieuXuat();
    getRecordTTPhieuXuat();
  }

  Future<void> getRecord() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.1.12/practice_api/TT_daily.php'));
      if (response.statusCode == 200) {
        setState(() {
          users = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        });
      } else {
        print('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getRecordSanPham() async {
    try {
      final responseSP = await http
          .get(Uri.parse('http://192.168.1.12/practice_api/view_data.php'));
      if (responseSP.statusCode == 200) {
        setState(() {
          product =
              List<Map<String, dynamic>>.from(jsonDecode(responseSP.body));
        });
      } else {
        print('Failed to load users: ${responseSP.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getRecordChiTietPhieuXuat() async {
    try {
      final responseTT = await http.get(Uri.parse(
          'http://192.168.1.12/practice_api/TT_chitietPhieuXuat.php'));
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

  Future<void> getRecordTTPhieuXuat() async {
    try {
      final responseTT = await http
          .get(Uri.parse('http://1192.168.1.2/practice_api/TT_Phieuxuat.php'));
      if (responseTT.statusCode == 200) {
        setState(() {
          shop = List<Map<String, dynamic>>.from(jsonDecode(responseTT.body));
        });
      } else {
        print('Failed to load users: ${responseTT.statusCode}');
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
        toolbarHeight: 56,
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
              'Thông tin đại lý',
              style: AppStyle.bold(color: Colors.white),
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.filter_alt_outlined,
                  color: Colors.white,
                ))
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: ListView(
          children: [
            if (users.isNotEmpty && widget.idShop < users.length)
              _buildCell('Mã đại lý: ${users[widget.idShop]['MaDaiLy']}'),
            if (users.isNotEmpty && widget.idShop < users.length)
              _buildCell('Tên đại lý: ${users[widget.idShop]['TenDaiLy']}'),
            if (users.isNotEmpty && widget.idShop < users.length)
              _buildCell('Địa chỉ: ${users[widget.idShop]['DiaChi']}'),
            if (users.isNotEmpty && widget.idShop < users.length)
              _buildCell('Số điện thoại: ${users[widget.idShop]['DienThoai']}'),
            if (users.isNotEmpty && widget.idShop < users.length)
              _buildCell('Tiền nợ: ${users[widget.idShop]['SoTienNo']}'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'Chi tiết xuất hàng đại lý',
                style: AppStyle.bold(),
              ),
            ),
            Container(
              height: Get.height * 0.5,
              child: ListView.builder(
                itemCount: ticket.length,
                itemBuilder: (context, index) {
                  if (users.isNotEmpty &&
                      ticket.isNotEmpty &&
                      product.isNotEmpty &&
                      widget.idShop < users.length &&
                      index < ticket.length &&
                      users[widget.idShop]['MaDaiLy'] ==
                          ticket[index]['MaDaiLy']) {
                    return Container(
                      child: Column(
                        children: [
                          Text('Mã phiếu xuất: ${ticket[index]['MaPhieu']}'),
                          Column(
                            children: [
                              _buildCell(
                                  'Mã sản phẩm đã xuất: ${ticket[index]['MaSanPham']}'),
                              _buildCell(
                                  'Số lượng: ${ticket[index]['SoLuongXuat']}'),
                              _buildCell(
                                  'Thành tiền: ${ticket[index]['TongTien']} VNĐ'),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCell(String infor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: Get.width * 0.7,
                child: Text(
                  infor,
                  style: AppStyle.regular(),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: 0.1,
            width: Get.width * 0.9,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
