import 'dart:convert';

import 'package:drink_app_getx/app/screen/product/product_update.dart';
import 'package:drink_app_getx/app/widget/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../core/values/colors.dart';
import '../../core/values/strings.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final TextEditingController id = TextEditingController();
  final TextEditingController namepro = TextEditingController();
  final TextEditingController count = TextEditingController();
  final TextEditingController type = TextEditingController();
  final TextEditingController pice = TextEditingController();
  final TextEditingController count_item = TextEditingController();
  List<Map<String, dynamic>> users = [];
  Future<void> getRecord() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.203.241/practice_api/view_data.php'));
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

  Future<void> insertRecord() async {
    if (id.text != "" &&
        namepro.text != "" &&
        type.text != "" &&
        pice.text != "" &&
        count_item.text != "") {
      try {
        String uri = "http://192.168.203.241/practice_api/add_product.php";
        var res = await http.post(Uri.parse(uri), body: {
          "MaSanPham": id.text,
          "TenSanPham": namepro.text,
          "LoaiSanPham": type.text,
          "SoLuongTon": count_item.text,
          "DonGia": pice.text,
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

  Future<void> delProduct(String id) async {
    try {
      String uri = "http://192.168.203.241/practice_api/delete_product.php";
      var res = await http.post(Uri.parse(uri), body: {"MaSanPham": id});
      var response = jsonDecode(res.body);
      if (response['success'] == 'true') {
        print('record delete complete');
      } else {
        print('some issue');
      }
    } catch (e) {
      print(e);
    }
  }

  final searchController = TextEditingController();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  bool isCheckBox = false;
  bool isSearching = false;
  List<String> filterName = [];
  @override
  void initState() {
    getRecord();
    searchController.dispose();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100 - 44,
        backgroundColor: AppColors.primary,
        title: _buildAppBar(),
      ),
      body: _buildBodyContext(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.grey.shade50,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Thêm sản phẩm',
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
                    // margin: EdgeInsets.symmetric(horizontal: 33),
                    child: ListView(
                      children: [
                        _buildTextField('Mã sản phẩm', id),
                        Gap(8),
                        _buildTextField('Tên sản phẩm', namepro),
                        Gap(8),
                        _buildTextField('Loại sản phẩm', type),
                        Gap(8),
                        _buildTextField('Đơn giá', pice),
                        Gap(8),
                        _buildTextField('Số lượng', count_item),
                        // Gap(8),
                        // _buildTextField('Nhập link sản pẩm',image_item),
                        Gap(30),
                        InkWell(
                          onTap: () {
                            insertRecord();
                            Navigator.of(context).pop();
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ButtonApp(
              height: 40,
              width: Get.width * 0.5,
              title: '+ Thêm sản phẩm',
              color: Colors.white,
              colorTitle: Colors.red),
        ),
        // Optional: Set background color
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

  Widget _buildBodyContext() {
    return SmartRefresher(
        controller: _refreshController,
        onRefresh: _handleRefresh,
        child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
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
                                    'Số lượng: ${users[index]['SoLuongTon']}',
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
                                  Get.to(ProductAdd(), arguments: index);
                                },
                                icon: Icon(
                                  Icons.build_circle_outlined,
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              );
            }));
  }

  Widget _buildAppBar() {
    Get.put(SearchController());
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
        // Text(
        //   'Quản lý danh mục sản phẩm',
        //   style: AppStyle.bold(color: Colors.white, fontSize: 16),
        // ),
        Text(
          'Quản lý sản phẩm',
          style: AppStyle.bold(color: Colors.white),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white),
              child: const Icon(
                Icons.delete,
                color: AppColors.primary,
                size: 22,
              )),
        ),
      ],
    );
  }

  Future<void> _handleRefresh() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.203.241/practice_api/view_data.php'));

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
}
