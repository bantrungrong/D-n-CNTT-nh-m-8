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
import 'SelectedProductScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

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

  Future<void> insertRecord() async {
    print(idTicket.text);
    print('${selectedMaDaiLy.value}');
    print(nameUser.text);
    print('${selectedDateExport.toLocal()}'.split(' ')[0].toString());
    print(write.text);
    print(writeTake.text);
    print(writeManager.text);
    print('${selectedDate.toLocal()}'.split(' ')[0].toString());
    print(number.text);
    if (idTicket.text != "" &&
        nameUser.text != "" &&
        write.text != "" &&
        writeManager.text != "") {
      try {
        String uri = "http://192.168.1.2/practice_api/add_phieu_xuat.php";
        var res = await http.post(Uri.parse(uri), body: {
          "MaPhieu": idTicket.text,
          "MaDaiLy": '${selectedMaDaiLy.value}',
          "TenNguoiNhan": nameUser.text,
          "NgayXuat": '${selectedDateExport.toLocal()}'.split(' ')[0],
          "ChuKyViet": write.text,
          "ChuKyNhan": writeTake.text,
          "ChuKyTruongDonVi": writeManager.text,
          "NgayCapMinistry": '${selectedDate.toLocal()}'.split(' ')[0],
          "SoGiayChungNhan": number.text,
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
          _buildTextField('Tên người nhận', nameUser),
          _buildTextField('Chữ ký viết', write),
          _buildTextField('Chữ ký nhận', writeTake),
          _buildTextField('Chữ ký trưởng đơn vị', writeManager),
          GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: _buildSelectedDate(
                  'Chọn ngày cấp', '${selectedDate.toLocal()}')),
          _buildTextField('Số giấy chứng nhận', number),
          GestureDetector(
              onTap: () {
                insertRecord();
                Get.to(SelectedProductScreen(
                  idShop: selectedMaDaiLy.value,
                  idTicket: idTicket.text,
                  nameTake: nameUser.text,
                  dateExport: '${selectedDateExport.toLocal()}'.split(' ')[0],
                  write: write.text,
                  writeTake: writeTake.text,
                  writeManager: writeManager.text,
                  dateImport: '${selectedDate.toLocal()}'.split(' ')[0],
                  numberNote: number.text,
                ));
              },
              child: _buildSelectedDate('Chọn sản phẩm xuất', '')),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              if (idTicket.text != '' &&
                  '${selectedMaDaiLy.value}' != '' &&
                  nameUser.text != '' &&
                  '${selectedDateExport.toLocal()}'.split(' ')[0] != '' &&
                  write.text != '' &&
                  writeTake.text != '' &&
                  writeManager.text != '' &&
                  '${selectedDate.toLocal()}'.split(' ')[0] != '' &&
                  number.text != '') {
                Get.to(DetailTicket(
                  idTicketInfor: idTicket.text,
                  idShopInfor: '${selectedMaDaiLy.value}',
                  nameInfor: nameUser.text,
                  dateInfor: '${selectedDateExport.toLocal()}'.split(' ')[0],
                  writeInfor: write.text,
                  wireTakeInfor: writeTake.text,
                  writeManagerInfor: writeManager.text,
                  dateImportInfor: '${selectedDate.toLocal()}'.split(' ')[0],
                  numberInfor: number.text,
                ));
              } else
                Fluttertoast.showToast(msg: 'Nhập đủ thông tin mới thêm');
            },
            child: ButtonApp(
                height: 55,
                width: Get.width * 0.7,
                title: '+ Thêm phiếu xuất',
                color: Colors.red,
                colorTitle: Colors.white),
          ),
          SizedBox(
            height: 24,
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
