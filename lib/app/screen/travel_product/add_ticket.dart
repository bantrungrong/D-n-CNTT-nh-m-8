import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../core/values/colors.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../core/values/strings.dart';
import 'SelectedProductScreen.dart';

class AddTicket extends StatefulWidget {
  const AddTicket({
    super.key,
  });

  @override
  State<AddTicket> createState() => _AddTicketState();
}

class _AddTicketState extends State<AddTicket> {
  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> save = [];
  TextEditingController idTicket = TextEditingController();
  TextEditingController idShop = TextEditingController();
  TextEditingController nameUser = TextEditingController();
  TextEditingController write = TextEditingController();
  TextEditingController writeTake = TextEditingController();
  TextEditingController writeManager = TextEditingController();
  TextEditingController number = TextEditingController();
  //////////
  DateTime selectedDateExport = DateTime.now();
  DateTime selectedDate = DateTime.now();
  var selectedMaDaiLy = ''.obs;
  var selectedTendaiLy = ''.obs;
  var selectedDiaChi = ''.obs;
  var selectedSDT = ''.obs;
  var selectedPice = ''.obs;
  void updateSelectedCompany(
      String Madaily, String Tendaily, String DiaChi, String SDT, String pice) {
    selectedMaDaiLy.value = Madaily;
    selectedTendaiLy.value = Tendaily;
    selectedDiaChi.value = DiaChi;
    selectedSDT.value = SDT;
    selectedPice.value = pice;
  }

  Future<void> _selectDateExport(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDateExport,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateExport)
      setState(() {
        selectedDateExport = picked;
      });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  void initState() {
    super.initState();
    getRecord();
  }

  Future<void> getRecord() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.1.2/practice_api/TT_daily.php'));
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
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: [
          _buildTextField('Nhập mã phiếu xuất', idTicket),
          Text(
            'Chọn đại lý',
            style: AppStyle.medium(),
          ),
          SizedBox(
            height: 12,
          ),
          _buildSelectedShop(),
          GestureDetector(
              onTap: () {
                _selectDateExport(context);
              },
              child: _buildSelectedDate(
                  'Chọn ngày xuất', '${selectedDateExport.toLocal()}')),
          _buildTextField('Tên người nhận', idTicket),
          _buildTextField('Chữ ký viết', idTicket),
          _buildTextField('Chữ ký nhận', idTicket),
          _buildTextField('Chữ ký trưởng đơn vị', idTicket),
          GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: _buildSelectedDate(
                  'Chọn ngày cấp', '${selectedDate.toLocal()}')),
          _buildTextField('Số giấy chứng nhận', idTicket),
          GestureDetector(
              onTap: () {
                Get.to(SelectedProductScreen(
                  idShop: idShop.text,
                  idTicket: idTicket.text,
                ));
              },
              child: _buildSelectedDate('Chọn sản phẩm xuất', ''))
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

  Widget _buildSelectedDate(String title, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 12,
        ),
        Text(
          title,
          style: AppStyle.medium(),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          width: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                time.split(' ')[0],
                style: AppStyle.regular(),
              ),
              Icon(Icons.keyboard_arrow_down)
            ],
          ),
        ),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }

  Widget _buildSelectedShop() {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: Text('Chọn công ty'),
                // insetPadding: const EdgeInsets.all(25),
                content: Container(
                  height: Get.height * 0.8,
                  width: Get.width * 0.9,
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          updateSelectedCompany(
                            users[index]['MaDaiLy'],
                            users[index]['TenDaiLy'],
                            users[index]['DiaChi'],
                            users[index]['DienThoai'],
                            users[index]['SoTienNo'],
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
                                'Mã đại lý:${users[index]['MaDaiLy']}',
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Tên đại lý:${users[index]['TenDaiLy']}',
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Địa chỉ:${users[index]['DiaChi']}',
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Số điện thoại: ${users[index]['DienThoai']}',
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Số tiền nợ: ${users[index]['SoTienNo']}',
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
                        selectedMaDaiLy.isEmpty
                            ? ''
                            : 'Mã Đại Lý: ${selectedMaDaiLy.value}',
                        style: TextStyle(fontSize: 15),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        selectedTendaiLy.isEmpty
                            ? ''
                            : 'Tên đại lý: ${selectedTendaiLy.value}',
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
                      Text(
                        selectedSDT.isEmpty
                            ? ''
                            : 'Số điện thoại: ${selectedSDT.value}',
                        style: TextStyle(fontSize: 15),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        selectedSDT.isEmpty
                            ? ''
                            : 'Số tiền nợ: ${selectedPice.value}',
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
