import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/values/colors.dart';
import 'package:http/http.dart' as http;
import '../../core/values/colors.dart';
import 'package:get/get.dart';
import '../../core/values/strings.dart';
class TravelProduct extends StatefulWidget {
  const TravelProduct({super.key});

  @override
  State<TravelProduct> createState() => _TravelProductState();
}

class _TravelProductState extends State<TravelProduct> {
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    getRecord();
  }

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
        child: Container(
          height: 55,
          width: Get.width*0.5,
          margin: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(12)
          ),
          child: Center(child: Text('Đồng ý xuất',style: AppStyle.bold(color: Colors.white),)),
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
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: Get.width*0.45,
                      child: Text('${users[index]['TenSanPham']}',overflow: TextOverflow.ellipsis,)),
                   Text('số lượng:${users[index]['count_item']}',style: AppStyle.regular(fontSize: 13),),
                ],
              ),
              value: users[index]['isChecked'] ?? false,
              onChanged: (bool? value) {
                setState(() {
                  users[index]['isChecked'] = value;
                });
              },
            )
          ),
        );
      },
    );
  }
}
