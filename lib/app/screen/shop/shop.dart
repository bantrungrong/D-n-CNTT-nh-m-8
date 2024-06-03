import 'dart:convert';
import 'package:drink_app_getx/app/core/values/strings.dart';
import 'package:drink_app_getx/app/screen/shop/shop_detail.dart';
import 'package:drink_app_getx/app/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gap/gap.dart';
import '../../core/values/colors.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserListScreen extends StatefulWidget {
  final String admin;
  const UserListScreen({super.key, required this.admin});
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> admin = [];
  final TextEditingController MaDaiLy = TextEditingController();
  final TextEditingController TenDaiLy = TextEditingController();
  final TextEditingController DiaChi = TextEditingController();
  final TextEditingController SoDienThoai = TextEditingController();
  final TextEditingController SoTienNo = TextEditingController();

  @override
  void initState() {
    super.initState();
    getRecord();
    getRecordAdmin();
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

  Future<void> getRecordAdmin() async {
    try {
      final responseAd = await http
          .get(Uri.parse('http://192.168.1.5/practice_api/login_data.php'));
      if (responseAd.statusCode == 200) {
        setState(() {
          admin = List<Map<String, dynamic>>.from(jsonDecode(responseAd.body));
        });
      } else {
        print('Failed to load users: ${responseAd.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> insertRecord() async {
    if (SoDienThoai.text.isNotEmpty &&
        MaDaiLy.text.isNotEmpty &&
        TenDaiLy.text.isNotEmpty &&
        SoTienNo.text.isNotEmpty) {
      try {
        String uri = "http://192.168.1.5/practice_api/add_TT_daily.php";
        var res = await http.post(Uri.parse(uri), body: {
          "MaDaiLy": MaDaiLy.text,
          "TenDaiLy": TenDaiLy.text,
          "DiaChi": DiaChi.text,
          "DienThoai": SoDienThoai.text,
          "SoTienNo": SoTienNo.text,
        });
        var reponseT = jsonDecode(res.body);
        if (reponseT["success"] == "true") {
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
      String uri = "http://192.168.1.5/practice_api/delete_daily.php";
      var res = await http.post(Uri.parse(uri), body: {"MaDaiLy": id});
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
              'Đại lý',
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
      body: Column(
        children: [
          _buildListView(),
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
                            _buildTextField('Mã đại lý', MaDaiLy),
                            Gap(8),
                            _buildTextField('Tên đại lý', TenDaiLy),
                            Gap(8),
                            _buildTextField('Số điện thoại', SoDienThoai),
                            Gap(8),
                            _buildTextField('Địa chỉ', DiaChi),
                            Gap(8),
                            _buildTextField('Tiền nợ', SoTienNo),
                            Gap(8),
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
            child: ButtonApp(
                height: 55,
                width: Get.width * 0.7,
                title: '+ Thêm thông tin đại lý',
                color: Colors.white,
                colorTitle: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return Container(
      height: Get.height * 0.8,
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(Shopdetail(
                idShop: index,
              ));
            },
            child: Container(
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
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.account_tree_outlined,
                          size: 18,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Mã đại lý ${users[index]['MaDaiLy']}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.account_tree_outlined,
                          size: 18,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Tên đại lý: ${users[index]['TenDaiLy']}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.account_tree_outlined,
                          size: 18,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            width: Get.width * 0.6,
                            child: Text(
                              'Địa chỉ: ${users[index]['DiaChi']}',
                              overflow: TextOverflow.ellipsis,
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.account_tree_outlined,
                          size: 18,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Số điện thoại: ${users[index]['DienThoai']}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.account_tree_outlined,
                          size: 18,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            width: Get.width * 0.6,
                            child: Text(
                              'Số tiền nợ: ${users[index]['SoTienNo']}',
                              overflow: TextOverflow.ellipsis,
                            )),
                      ],
                    ),
                  ],
                ),
                trailing: IconButton(
                  onPressed: () {
                    delProduct('Mã đại lý ${users[index]['MaDaiLy']}');
                  },
                  icon: Icon(Icons.delete),
                ),
              ),
            ),
          );
        },
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
