import 'dart:convert';

import 'package:drink_app_getx/app/screen/product/product_detail.dart';
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
  List<Map<String, dynamic>> filteredUsers = []; // For filtered list
  List<Map<String, dynamic>> factory = [];
  final searchController = TextEditingController();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  bool isCheckBox = false;
  bool isSearching = false;
  List<String> filterName = [];
  List<String> selectedIndex = ['Tất cả', 'Hết hàng', 'Còn hàng'];
  int selected = 0;

  @override
  void initState() {
    getRecord();
    getRecordF();
    super.initState();
  }

  Future<void> getRecord() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.1.5/practice_api/practice_api/view_data.php'));
      if (response.statusCode == 200) {
        setState(() {
          users = List<Map<String, dynamic>>.from(jsonDecode(response.body));
          filterUsers(); // Apply initial filtering
        });
      } else {
        print('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getRecordF() async {
    try {
      final responseF = await http.get(Uri.parse(
          'http://192.168.1.5/practice_api/practice_api/TT_xuong_sx.php'));
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
    if (id.text.isNotEmpty &&
        namepro.text.isNotEmpty &&
        type.text.isNotEmpty &&
        pice.text.isNotEmpty &&
        count_item.text.isNotEmpty) {
      try {
        String uri =
            "http://192.168.1.5/practice_api/practice_api/add_product.php";
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
          getRecord(); // Refresh the list after adding a new product
        } else {
          print("some issue");
        }
      } catch (e) {
        print(e);
      }
    } else {
      Fluttertoast.showToast(msg: 'Nhập đầy đủ thông tin mới thêm');
    }
  }

  Future<void> delProduct(String id) async {
    try {
      String uri =
          "http://192.168.1.5/practice_api/practice_api/delete_product.php";
      var res = await http.post(Uri.parse(uri), body: {"MaSanPham": id});
      var response = jsonDecode(res.body);
      if (response['success'] == 'true') {
        print('record delete complete');
        getRecord(); // Refresh the list after deleting a product
      } else {
        print('some issue');
      }
    } catch (e) {
      print(e);
    }
  }

  void filterUsers() {
    setState(() {
      if (selected == 0) {
        filteredUsers = users;
      } else if (selected == 1) {
        filteredUsers =
            users.where((user) => user['SoLuongTon'] == '0').toList();
      } else {
        filteredUsers =
            users.where((user) => user['SoLuongTon'] != '0').toList();
      }
    });
  }

  void searchUsers(String query) {
    setState(() {
      if (query.isEmpty) {
        filterUsers();
      } else {
        filteredUsers = users
            .where((user) =>
                user['TenSanPham'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 56,
        backgroundColor: AppColors.primary,
        title: _buildAppBar(),
      ),
      body: ListView(
        children: [
          Container(
            height: 33,
            // padding: EdgeInsets.symmetric(horizontal: 16),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade100),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: selectedIndex.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = index;
                          filterUsers();
                        });
                      },
                      child: Container(
                          width: Get.width * 0.3,
                          decoration: BoxDecoration(
                              color: selected == index
                                  ? Colors.red
                                  : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12)),
                          padding: EdgeInsets.symmetric(horizontal: 22),
                          child: Text(selectedIndex[index])),
                    ),
                  );
                }),
          ),
          Container(
              height: Get.height * 0.75,
              width: Get.width * 0.9,
              child: _buildBodyContext()),
          GestureDetector(
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
            child: Container(
              margin: EdgeInsets.only(bottom: 33, left: 16, right: 16),
              child: ButtonApp(
                  height: 55,
                  width: Get.width * 0.2,
                  title: '+ Thêm sản phẩm',
                  color: Colors.white,
                  colorTitle: Colors.red),
            ),
          ),
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

  Widget _buildBodyContext() {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _handleRefresh,
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(
            filteredUsers.length,
            (index) => Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset:
                        const Offset(0, 2), // changes the direction of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(ProductDetail(
                        DonGia: filteredUsers[index]['DonGia'],
                        LoaiSanPham: filteredUsers[index]['LoaiSanPham'],
                        MaSanPham: filteredUsers[index]['MaSanPham'],
                        SoLuong: filteredUsers[index]['SoLuongTon'],
                        TenSanPham: filteredUsers[index]['TenSanPham'],
                        MaPhanXuong: factory[index]['MaPhanXuong'],
                        TenPhanXuong: factory[index]['TenPhanXuong'],
                        DiaChi: factory[index]['DiaChi'],
                      ));
                    },
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mã SP: ${filteredUsers[index]['MaSanPham']}',
                            style: AppStyle.medium(fontSize: 14)
                                .copyWith(fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Tên SP: ${filteredUsers[index]['TenSanPham']}',
                            style: AppStyle.medium(fontSize: 14)
                                .copyWith(fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Loại SP: ${filteredUsers[index]['LoaiSanPham']}',
                            style: AppStyle.medium(fontSize: 14)
                                .copyWith(fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Đơn giá: ${filteredUsers[index]['DonGia']}',
                            style: AppStyle.medium(fontSize: 14)
                                .copyWith(fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Số lượng: ${filteredUsers[index]['SoLuongTon']}',
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
                                  filteredUsers[index]['SoLuongTon'] == '0'
                                      ? 'Hết hàng'
                                      : 'Còn hàng',
                                  style: AppStyle.bold(
                                    fontSize: 13,
                                    color: filteredUsers[index]['SoLuongTon'] ==
                                            '0'
                                        ? Colors.red
                                        : Colors.green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Get.to(ProductUpdate(), arguments: index);
                        },
                        icon: Icon(
                          Icons.build_circle_outlined,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return isSearching
        ? TextField(
            controller: searchController,
            autofocus: true,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Tìm kiếm sản phẩm...',
              hintStyle: TextStyle(color: Colors.white70),
              border: InputBorder.none,
            ),
            onChanged: searchUsers,
          )
        : Row(
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
                'Quản lý sản phẩm',
                style: AppStyle.bold(color: Colors.white),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isSearching = !isSearching;
                    if (!isSearching) {
                      searchController.clear();
                      filterUsers();
                    }
                  });
                },
                child: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white),
                    child: Icon(
                      isSearching ? Icons.close : Icons.search,
                      color: AppColors.primary,
                      size: 22,
                    )),
              ),
            ],
          );
  }

  Future<void> _handleRefresh() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.1.5/practice_api/practice_api/view_data.php'));
      if (response.statusCode == 200) {
        setState(() {
          users = List<Map<String, dynamic>>.from(jsonDecode(response.body));
          filterUsers(); // Apply filtering after refresh
        });
      } else {
        print('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      _refreshController.refreshCompleted();
    }
  }
}
