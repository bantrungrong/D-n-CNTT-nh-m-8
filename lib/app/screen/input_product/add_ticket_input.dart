import 'dart:convert';

import 'package:drink_app_getx/app/screen/travel_product/detail_ticket.dart';
import 'package:drink_app_getx/app/widget/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../core/values/colors.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../core/values/strings.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class AddInput extends StatefulWidget {
  const AddInput({
    super.key,
  });

  @override
  State<AddInput> createState() => _AddInputState();
}

class _AddInputState extends State<AddInput> {
  List<Map<String, dynamic>> factory = [];
  List<Map<String, dynamic>> product = [];
  TextEditingController MaPhieuNhap = TextEditingController();
  TextEditingController TenNguoiGiaoHang = TextEditingController();
  TextEditingController SoLuongNhap = TextEditingController();
  TextEditingController ChuKyViet = TextEditingController();
  TextEditingController ChuKyNhan = TextEditingController();
  TextEditingController ChuKyTruongDonVi = TextEditingController();
  /////
  var selectedMaSanPham = ''.obs;
  var selectedSoHieuXuong = ''.obs;
  var selectedTenSanPham = ''.obs;
  var selectedDonGia = ''.obs;

  var selectedTenPhanXuong = ''.obs;
  var selectedDiaChi = ''.obs;
  void updateSelectedFactory(
      String SoHieuXuong, String TenPhanXuong, String DiaCHi) {
    selectedSoHieuXuong.value = SoHieuXuong;
    selectedTenPhanXuong.value = TenPhanXuong;
    selectedDiaChi.value = DiaCHi;
  }

  void updateSelectedProduct(
      String MaSanPham, String TenSanPham, String DonGia) {
    selectedMaSanPham.value = MaSanPham;
    selectedTenSanPham.value = TenSanPham;
    selectedDonGia.value = DonGia;
  }

  @override
  void initState() {
    super.initState();
    getRecordFactory();
    getRecordProduct();
  }

  Future<void> getRecordProduct() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.1.5/practice_api/view_data.php'));
      if (response.statusCode == 200) {
        setState(() {
          product = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        });
      } else {
        print('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getRecordFactory() async {
    try {
      final responseF = await http
          .get(Uri.parse('http://192.168.1.5/practice_api/TT_xuong_sx.php'));
      if (responseF.statusCode == 200) {
        setState(() {
          factory = List<Map<String, dynamic>>.from(jsonDecode(responseF.body));
        });
      } else {
        print('Failed to load users: ${responseF.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> insertRecord() async {
    if (MaPhieuNhap.text != "" &&
        TenNguoiGiaoHang.text != "" &&
        SoLuongNhap.text != "" &&
        ChuKyViet.text != "" &&
        ChuKyNhan.text != "" &&
        ChuKyTruongDonVi.text != "") {
      try {
        double soLuong = double.parse(SoLuongNhap.text);
        double donGia = double.parse(selectedDonGia.value);
        double tongTien = soLuong * donGia;
        // print(tongTien);
        String uri = "http://192.168.1.5/practice_api/add_phieu_nhap.php";
        var res = await http.post(Uri.parse(uri), body: {
          "MaPhieuNhap": MaPhieuNhap.text,
          "MaSanPham": selectedMaSanPham.value,
          "SoHieuXuong": selectedSoHieuXuong.value,
          "TenNguoiGiaoHang": TenNguoiGiaoHang.text,
          "TenSanPham": selectedTenSanPham.value,
          "DonGia": selectedDonGia.value,
          "SoLuongNhap": SoLuongNhap.text,
          "ThanhTien": '$tongTien',
          "TongTien": '$tongTien',
          "ChuKyViet": ChuKyViet.text,
          "ChuKyNhan": ChuKyNhan.text,
          "ChuKyTruongDonVi": ChuKyTruongDonVi.text,
        });
        var reponse = jsonDecode(res.body);
        if (reponse["success"] == "true") {
          Fluttertoast.showToast(msg: 'Thêm thành công');
        } else {
          print("some issue");
        }
      } catch (e) {
        print(e);
      }
    } else
      Fluttertoast.showToast(msg: 'Nhập đầy đủ thông tin mới thêm');
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
              'Tạo phiếu xuất',
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
      body: _buildBodyContext(),
    );
  }

  Widget _buildBodyContext() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: [
          _buildTextField('Nhập mã phiếu nhập', MaPhieuNhap),
          _buildTextField('Nhập tên người giao', TenNguoiGiaoHang),
          _buildTextField('Nhập nhập số lượng', SoLuongNhap),
          _buildTextField('Nhập chữ ký viết:', ChuKyViet),
          _buildTextField('Nhập chữ ký nhận:', ChuKyNhan),
          _buildTextField('Chữ ký trưởng đơn vị:', ChuKyTruongDonVi),
          Text(
            'Chọn thông tin xưởng sản xuất',
            style: AppStyle.medium(),
          ),
          SizedBox(
            height: 10,
          ),
          _buildSelectedFactory(),
          Text(
            'Chọn thông tin sản phẩm',
            style: AppStyle.medium(),
          ),
          SizedBox(
            height: 10,
          ),
          _buildSelectedProduct(),
          SizedBox(
            height: 10,
          ),
          // Text(
          //   'Tổng tiền: $tongTien',
          //   style: AppStyle.medium(),
          // ),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              insertRecord();
            },
            child: ButtonApp(
                height: 55,
                width: Get.width * 0.7,
                title: 'Tạo phiếu nhập',
                color: Colors.red,
                colorTitle: Colors.white),
          ),
          SizedBox(
            height: 34,
          )
        ],
      ),
    );
  }

  Widget _buildTextField(String title, TextEditingController name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyle.medium(
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          width: MediaQuery.of(context).size.height,
          child: TextField(
            controller: name,
            maxLines: 1,
            decoration: const InputDecoration(
              errorStyle: TextStyle(height: 0),
              contentPadding: EdgeInsets.all(10),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(
          height: 12,
        )
      ],
    );
  }

  Widget _buildSelectedFactory() {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: Text('Chọn xưởng sản xuất'),
                // insetPadding: const EdgeInsets.all(25),
                content: Container(
                  height: Get.height * 0.8,
                  width: Get.width * 0.9,
                  child: ListView.builder(
                    itemCount: factory.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          updateSelectedFactory(
                            factory[index]['MaPhanXuong'],
                            factory[index]['TenPhanXuong'],
                            factory[index]['DiaChi'],
                          );
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Colors.black))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mã phân xưởng: ${factory[index]['MaPhanXuong']}',
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Tên phân xưởng:${factory[index]['TenPhanXuong']}',
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Địa chỉ: ${factory[index]['DiaChi']}',
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Mã Sản phẩm: ${factory[index]['MaSanPham']}',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ));
          },
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => Container(
                  width: Get.width * 0.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedSoHieuXuong.isEmpty
                            ? ''
                            : 'Mã phân xưởng: ${selectedSoHieuXuong.value}',
                        style: TextStyle(fontSize: 15),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        selectedTenPhanXuong.isEmpty
                            ? ''
                            : 'Tên phân xưởng: ${selectedTenPhanXuong.value}',
                        style: TextStyle(fontSize: 15),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        selectedDiaChi.isEmpty
                            ? ''
                            : 'Địa chỉ: ${selectedDiaChi.value}',
                        style: TextStyle(fontSize: 15),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )),
            Icon(Icons.keyboard_arrow_down)
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedProduct() {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: Text('Chọn Sản phẩm'),
                // insetPadding: const EdgeInsets.all(25),
                content: Container(
                  height: Get.height * 0.8,
                  width: Get.width * 0.9,
                  child: ListView.builder(
                    itemCount: product.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          updateSelectedProduct(
                            product[index]['MaSanPham'],
                            product[index]['TenSanPham'],
                            product[index]['DonGia'],
                          );
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Colors.black))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mã sản phẩm: ${product[index]['MaSanPham']}',
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Tên sản phẩm:${product[index]['TenSanPham']}',
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Đơn giá: ${product[index]['DonGia']}',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ));
          },
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => Container(
                  width: Get.width * 0.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedMaSanPham.isEmpty
                            ? ''
                            : 'Mã sản phẩm: ${selectedMaSanPham.value}',
                        style: TextStyle(fontSize: 15),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        selectedTenSanPham.isEmpty
                            ? ''
                            : 'Tên sản phẩm: ${selectedTenSanPham.value}',
                        style: TextStyle(fontSize: 15),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        selectedDonGia.isEmpty
                            ? ''
                            : 'Đơn giá: ${selectedDonGia.value}',
                        style: TextStyle(fontSize: 15),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )),
            Icon(Icons.keyboard_arrow_down)
          ],
        ),
      ),
    );
  }
}
