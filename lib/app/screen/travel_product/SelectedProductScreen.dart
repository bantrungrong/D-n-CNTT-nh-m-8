import 'dart:convert';
import 'package:drink_app_getx/app/screen/travel_product/detail_ticket.dart';
import 'package:drink_app_getx/app/widget/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import '../../core/values/colors.dart';
import '../../core/values/strings.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class SelectedProductScreen extends StatefulWidget {
  final String idTicket;
  final String idShop;

  final String nameTake;
  final String dateExport;
  final String write;
  final String writeTake;
  final String writeManager;
  final String dateImport;
  final String numberNote;

  const SelectedProductScreen(
      {super.key,
      required this.idShop,
      required this.idTicket,
      required this.dateExport,
      required this.dateImport,
      required this.nameTake,
      required this.numberNote,
      required this.write,
      required this.writeManager,
      required this.writeTake});

  @override
  State<SelectedProductScreen> createState() => _SelectedProductScreenState();
}

class _SelectedProductScreenState extends State<SelectedProductScreen> {
  TextEditingController count = TextEditingController();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    getRecord();
    _handleRefresh();
  }

  List<Map<String, dynamic>> users = [];
  Future<void> getRecord() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.1.5/practice_api/view_data.php'));
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

  Future<void> insertRecord(String idProduct, String piceCount) async {
    if (count.text != '') {
      try {
        double soLuong = double.parse(count.text);
        double donGia = double.parse(piceCount);
        double tongTien = soLuong * donGia;
        print(tongTien);
        String uri =
            "http://192.168.1.5/practice_api/add_chi_tiet_phieuxuat.php";
        var res = await http.post(Uri.parse(uri), body: {
          "MaPhieu": widget.idTicket,
          "MaDaiLy": widget.idShop,
          "MaSanPham": idProduct,
          "SoLuongXuat": count.text,
          "DonGia": piceCount,
          "TongTien": '$tongTien',
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

  Future<void> _handleRefresh() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.1.5/practice_api/view_data.php'));

      if (response.statusCode == 200) {
        setState(() {
          users = List<Map<String, dynamic>>.from(jsonDecode(response.body));
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
              'Chọn sản phẩm xuất',
              style: AppStyle.bold(color: Colors.white),
            ),
            Container()
          ],
        ),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _handleRefresh,
        child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return users[index]['SoLuongTon'] != '0'
                  ? Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
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
                            onTap: () {},
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Mã SP: ${users[index]['MaSanPham']}',
                                    style: AppStyle.medium(fontSize: 14)
                                        .copyWith(fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Tên SP: ${users[index]['TenSanPham']}',
                                    style: AppStyle.medium(fontSize: 14)
                                        .copyWith(fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Loại SP: ${users[index]['LoaiSanPham']}',
                                    style: AppStyle.medium(fontSize: 14)
                                        .copyWith(fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Đơn giá: ${users[index]['DonGia']}',
                                    style: AppStyle.medium(fontSize: 14)
                                        .copyWith(fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    'Số lượng còn: ${users[index]['SoLuongTon']}',
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
                                          users[index]['SoLuongTon'] == '0'
                                              ? 'Hết hàng'
                                              : 'Còn hàng',
                                          style: AppStyle.regular(
                                              fontSize: 13,
                                              color: users[index]
                                                          ['SoLuongTon'] ==
                                                      '0'
                                                  ? Colors.red
                                                  : Colors.green),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Container(
                                          height: Get.height * 0.5,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Tạo chi tiết phiếu xuất',
                                                style: AppStyle.bold(
                                                    color: Colors.red),
                                              ),
                                              Gap(12),
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Mã phiếu xuất: ${widget.idTicket}',
                                                      style: AppStyle.medium(),
                                                    ),
                                                    Gap(8),
                                                    Text(
                                                      'Mã đại lý: ${widget.idShop}',
                                                      style: AppStyle.medium(),
                                                    ),
                                                    Gap(8),
                                                    Text(
                                                      'Mã sản phẩm: ${users[index]['MaSanPham']}',
                                                      style: AppStyle.medium(),
                                                    ),
                                                    Gap(8),
                                                    Text(
                                                      'Đơn giá: ${users[index]['DonGia']}',
                                                      style: AppStyle.medium(),
                                                    ),
                                                    Text(
                                                      'Số lượng còn: ${users[index]['SoLuongTon']}',
                                                      style: AppStyle.medium(),
                                                    ),
                                                    Gap(8),
                                                    _buildTextField(
                                                        'Nhập số lượng xuất: ${count.text}',
                                                        count),
                                                    Gap(12),
                                                    GestureDetector(
                                                      onTap: () {
                                                        if (widget.idTicket !=
                                                                '' &&
                                                            widget.idTicket !=
                                                                '') {
                                                          setState(() {
                                                            insertRecord(
                                                                users[index][
                                                                    'MaSanPham'],
                                                                users[index]
                                                                    ['DonGia']);
                                                          });
                                                        } else
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  'Nhập mã đại lý và mã phiếu xuất mới thêm');
                                                        // Get.to(DetailTicket(
                                                        //     dateInfor: widget
                                                        //         .dateExport,
                                                        //     idShopInfor:
                                                        //         widget.idShop,
                                                        //     idTicketInfor:
                                                        //         widget.idTicket,
                                                        //     nameInfor:
                                                        //         widget.nameTake,
                                                        //     dateImportInfor:
                                                        //         widget
                                                        //             .dateImport,
                                                        //     numberInfor: widget
                                                        //         .numberNote,
                                                        //     wireTakeInfor:
                                                        //         widget
                                                        //             .writeTake,
                                                        //     writeInfor:
                                                        //         widget.write,
                                                        //     writeManagerInfor:
                                                        //         widget
                                                        //             .writeManager));
                                                      },
                                                      child: ButtonApp(
                                                          height: 55,
                                                          width:
                                                              Get.width * 0.8,
                                                          title:
                                                              'Thêm chi tiết',
                                                          color: Colors.red,
                                                          colorTitle:
                                                              Colors.white),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: Icon(Icons.add),
                              ),
                            ),
                          ),
                        ],
                      ))
                  : Container();
            }),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: GestureDetector(
      //   onTap: () {},
      //   child: ButtonApp(
      //       height: 55,
      //       width: Get.width * 0.7,
      //       title: 'Xuất hàng',
      //       color: Colors.white,
      //       colorTitle: Colors.red),
      // ),
    );
  }

  Widget _buildTextField(String title, TextEditingController name) {
    String _displayText = "Nhập số vào đây";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyle.medium(
            fontSize: 16,
          ),
        ),
        const Gap(8),
        Container(
          height: 55,
          width: Get.width * 0.8,
          child: TextField(
            controller: name,
            maxLines: 1,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              errorStyle: TextStyle(height: 0),
              contentPadding: EdgeInsets.all(10),
              border: OutlineInputBorder(),
            ),
            onChanged: (text) {
              setState(() {
                _displayText =
                    text.isEmpty ? "Nhập số vào đây" : "Bạn đã nhập: $text";
              });
            },
          ),
        )
      ],
    );
  }
}
