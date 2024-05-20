import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/values/colors.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../core/values/strings.dart';
import 'SelectedProductScreen.dart';
class TravelProduct extends StatefulWidget {
  const TravelProduct({super.key});

  @override
  State<TravelProduct> createState() => _TravelProductState();
}

class _TravelProductState extends State<TravelProduct> {
  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> save = [];
  @override
  void initState() {
    super.initState();
    getRecord();
    getNhapKho();
  }

  Future<void> getRecord() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.203.241/practice_api/view_data.php'));
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
  Future<void> getNhapKho() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.203.241/practice_api/nhap_kho.php'));
      if (response.statusCode == 200) {
        setState(() {
          save = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        });
      } else {
        print('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  List<Map<String, dynamic>> selectedProducts = [];
  int totalSelectedCount = 0;
  double totalValue = 0.0;

  void toggleProductSelection(int index) async  {
    setState(() {
      if (users[index]['isChecked'] == true) {
        users[index]['isChecked'] = false;
        selectedProducts.remove(users[index]);
        totalSelectedCount -= int.parse(users[index]['count_item']);
        totalValue -= double.parse(users[index+1]['count_item']) * double.parse(users[index+1]['DonGia']);
      } else {
        users[index]['isChecked'] = true;
        selectedProducts.add(users[index]);
        totalSelectedCount += int.parse(users[index]['count_item']);
        totalValue += double.parse(users[index]['count_item']) * double.parse(users[index]['DonGia']);
      }
      totalValue = 0;
      for (var product in selectedProducts) {
        totalValue += double.parse(product['count_item']) * double.parse(product['DonGia']);
      }
    });
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
            Text('Chọn sản phẩm xuất hàng',style: AppStyle.bold(color: Colors.white),),
            IconButton(onPressed: (){}, icon: Icon(Icons.apps,color: Colors.white,))
          ],
        ),
      ),
      body:_buildBodyContext(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: (){
          Get.to(() => SelectedProductScreen(selectedProducts: selectedProducts,totalSelectedCount: totalSelectedCount,totalValue: totalValue,),);
        },
        child: Container(
          height: 55,
          width: Get.width*0.5,
          margin: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.circular(12)
          ),
          child: Center(child: Text('Đồng ý xuất',style: AppStyle.bold(color: Colors.red),)),
        ),
      ),
    );
  }
  Widget _buildBodyContext(){

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context,index){
        return GestureDetector(
          onTap: (){
          },
          child: users[index]['count_item'] == '0'? Container(): Container(
            margin: EdgeInsets.symmetric(vertical: 6,horizontal: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 2), // changes the direction of shadow
                ),
              ],
            ),
            // color: Colors.red,
            child:CheckboxListTile(
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
                        .copyWith(fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Đơn giá: ${users[index]['DonGia']}',
                    style: AppStyle.medium(fontSize: 14)
                        .copyWith(fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Số lượng sản phẩm: ${users[index]['count_item']}',
                    style: AppStyle.medium(fontSize: 14)
                        .copyWith(fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text(
                        'Trạng thái:',
                        style: AppStyle.regular(fontSize: 13),
                      ),
                      TextButton(
                        onPressed: () {
                        },
                        child: Text(
                           users[index]['count_item'] == '0'  ? 'Hết hàng':'Còn hàng',
                          style: AppStyle.regular(
                              fontSize: 13, color: users[index]['count_item']== '0'? Colors.red:Colors.green),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              value: users[index]['isChecked'] ?? false,
              onChanged: (bool? value) {
                setState(() {
                  toggleProductSelection(index);
                });
              },
            )
          ),
        );
      },
    );
  }
}
