import 'dart:convert';

import 'package:drink_app_getx/app/widget/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../core/values/colors.dart';
import '../../core/values/strings.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({super.key});

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  final TextEditingController id = TextEditingController();
  final TextEditingController namepro = TextEditingController();
  final TextEditingController count = TextEditingController();
  final TextEditingController type = TextEditingController();
  final TextEditingController pice = TextEditingController();
  final TextEditingController count_item = TextEditingController();

  List<Map<String, dynamic>> users = [];
  Future<void> getRecord() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.5/practice_api/view_data.php'));
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
  Future<void> updateProduct()async{
    final value = Get.arguments as int;
    if (namepro.text.isEmpty ||
        type.text.isEmpty ||
        count.text.isEmpty ||
        pice.text.isEmpty ||
        count_item.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Vui lòng nhập đầy đủ thông tin');
      return; // Trả về khỏi phương thức nếu có bất kỳ trường nào trống
    }
    try{
      String uri = "http://192.168.1.5/practice_api/update_product.php";
      var res = await http.post(Uri.parse(uri),body: {
        "TenSanPham": namepro.text,
        "LoaiSanPham":type.text,
        "DungTich": count.text,
        "DonGia":pice.text,
        "count_item":count_item.text,
        "MaSanPham": users[value]['MaSanPham'],
      });
      var reponse = jsonDecode(res.body);
      if(reponse["success"]=="true"){
        Fluttertoast.showToast(msg: 'Sửa thành công');
      }
      else{
        print("some issue");
      }
    } catch(e){
      print(e);
    }
  }

  Future<void> delProduct(String id)async{
    try{
      String uri = "http://192.168.25.249/practice_api/delete_product.php";
      var res = await http.post(Uri.parse(uri),body: {"MaSanPham":id});
      var response = jsonDecode(res.body);
      if(response['success'] == 'true'){
        print('record delete complete');
      } else {
        print('some issue');
      }
    } catch (e){
      print(e);
    }
  }
  @override
  void initState(){
    getRecord();
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    final value = Get.arguments as int;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100 - 44,
        backgroundColor: AppColors.primary,
        title:_buildAppBar(),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Mã Sản phẩm: ${users[value]['MaSanPham']}',style: AppStyle.medium(fontSize: 16),)
                  ],
                ),
                Gap(12),
                _buildTextField('Tên Sản phẩm: ${users[value]['TenSanPham']}', namepro),
                Gap(10),
                _buildTextField('Loại sản phẩm: ${users[value]['LoaiSanPham']}', type),
                Gap(10),
                _buildTextField('Dung tích: ${users[value]['DungTich']}', count),
                Gap(10),
                _buildTextField('Đơn giá: ${users[value]['DonGia']}', pice),
                Gap(10),
                _buildTextField('Số lượng: ${users[value]['count_item']}', count_item),
                Gap(23),
                GestureDetector(
                  onTap: (){
                    if (namepro.text.isEmpty ||
                        type.text.isEmpty ||
                        count.text.isEmpty ||
                        pice.text.isEmpty ||
                        count_item.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Vui lòng nhập đầy đủ thông tin');
                      return; // Trả về khỏi phương thức nếu có bất kỳ trường nào trống
                    }
                    updateProduct();
                    Get.back();
                  },
                    child: ButtonApp(height: 55, width: 200, title: 'Xác nhận lưu', color: Colors.white, colorTitle: Colors.red))
              ],
            ),
          ),

        ],
      ),
    );
  }
  Widget _buildAppBar() {
    final value = Get.arguments as int;
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
          'Sửa thông tin sản phẩm',
          style: AppStyle.bold(color: Colors.white, fontSize: 16),
        ),
        GestureDetector(
          onTap: () {
            delProduct(users[value]['MaSanPham']);
            Get.back();
          },
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
  Widget _buildTextField(String title,TextEditingController name) {
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
          width: MediaQuery.of(context).size.height,

          child: TextField(
            controller: name,
            maxLines: 1,
            decoration: const InputDecoration(
              errorStyle: TextStyle(height: 0),
              contentPadding: EdgeInsets.all(10),
              border: OutlineInputBorder(
              ),
            ),
          ),
        )
      ],
    );
  }
}
