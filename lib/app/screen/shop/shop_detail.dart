import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/values/colors.dart';
import '../../core/values/strings.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:gap/gap.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  final TextEditingController TenDaiLy = TextEditingController();
  final TextEditingController DiaChi = TextEditingController();
  final TextEditingController SoDienThoai = TextEditingController();
  final TextEditingController SoTienNo = TextEditingController();
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
          .get(Uri.parse('http://192.168.1.5/practice_api/TT_daily.php'));
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
          .get(Uri.parse('http://192.168.1.5/practice_api/view_data.php'));
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
      final responseTT = await http.get(
          Uri.parse('http://192.168.1.5/practice_api/TT_chitietPhieuXuat.php'));
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

  Future<void> updateShop() async {
    try {
      String uri = "http://192.168.1.5/practice_api/update_daily.php";
      var res = await http.post(Uri.parse(uri), body: {
        "MaDaiLy": users[widget.idShop]['MaDaiLy'],
        "TenDaiLy": TenDaiLy.text,
        "DiaChi": DiaChi.text,
        "DienThoai": SoDienThoai.text,
        "SoTienNo": SoTienNo.text,
      });
      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        Fluttertoast.showToast(msg: 'Sửa thành công');
        getRecord(); // Refresh the data
      } else {
        print("some issue");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> delShop() async {
    final value = Get.arguments as int?;
    if (value == null || value >= users.length) return;

    try {
      String uri = "http://192.168.1.5/practice_api/delete_product.php";
      var resDel = await http.post(Uri.parse(uri), body: {
        "MaSanPham": users[value]['MaSanPham'],
      });
      var responseDel = jsonDecode(resDel.body);
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
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.grey.shade50,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sửa thông tin đại lý',
                                style: AppStyle.bold(fontSize: 18),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.close),
                              )
                            ],
                          ),
                          insetPadding: const EdgeInsets.all(12),
                          content: Container(
                            height: Get.height * 0.75,
                            width: Get.width * 1,
                            child: ListView(
                              children: [
                                Text(
                                    'Mã đại lý: ${users[widget.idShop]['MaDaiLy']}'),
                                Gap(8),
                                _buildTextField(
                                    'Tên đại lý: ${users[widget.idShop]['TenDaiLy']}',
                                    TenDaiLy),
                                Gap(8),
                                _buildTextField(
                                    'Số điện thoại: ${users[widget.idShop]['DienThoai']}',
                                    SoDienThoai),
                                Gap(8),
                                _buildTextField(
                                    'Địa chỉ: ${users[widget.idShop]['DiaChi']}',
                                    DiaChi),
                                Gap(8),
                                _buildTextField(
                                    'Tiền nợ: ${users[widget.idShop]['SoTienNo']}',
                                    SoTienNo),
                                Gap(8),
                                Gap(30),
                                InkWell(
                                  onTap: () {
                                    if (TenDaiLy.text == '' &&
                                        DiaChi.text == '' &&
                                        SoDienThoai.text == '' &&
                                        SoTienNo.text == '') {
                                      Fluttertoast.showToast(
                                          msg:
                                              'Vui lòng nhập đầy đủ thông tin');
                                      return;
                                    }
                                    Navigator.of(context).pop();
                                    updateShop();
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                        child: Text(
                                      'Xác nhận thêm',
                                      style: AppStyle.bold(),
                                    )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
                icon: Icon(
                  Icons.settings,
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

  Widget _buildTextField(String title, TextEditingController name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyle.medium(
            fontSize: 14,
          ),
        ),
        const Gap(8),
        SizedBox(
          width: MediaQuery.of(context).size.height,
          child: TextFormField(
            controller: name,
            readOnly: false,
            maxLines: 1,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              errorStyle: TextStyle(height: 0),
              contentPadding: EdgeInsets.all(10),
            ),
          ),
        )
      ],
    );
  }
}
