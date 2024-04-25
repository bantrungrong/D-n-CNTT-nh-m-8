

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/values/colors.dart';
import '../../core/values/strings.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  List userData = [];
  List<String> searchItem = [];
  Future<void> getRecord()async {
    String uri="http://192.168.1.5/practice_api/view_data.php";
    try{
      var reponse = await http.get(Uri.parse(uri));
      setState(() {
        userData = jsonDecode(reponse.body);
      });

    }catch(e){
      print(e);
    }
  }
  bool isSearch = true;
  //
  @override
  void initState(){
    getRecord();
    super.initState();
  }
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100 - 44,
        backgroundColor: AppColors.primary,
        title:isSearch?_buildAppBar():_buildTextField(),
      ),
      body: _buildBodyContext(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue, // Optional: Set background color
      ),
    );
  }

  Widget _buildBodyContext() {
    return SingleChildScrollView(
      child: Column(
          children: List.generate(
              userData.length,
              (index) =>GestureDetector(
                  onTap: () {},
                  child: _widgetUser(userData[index]['image_item'],userData[index]['id_item'],userData[index]['name_item'],userData[index]['type_item'],userData[index]['count_item'],userData[index]['pice_item'],userData[index]['status_item'],)
              )
              )
          )
      );

  }

  Widget _buildAppBar() {
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
          'Quản lý danh mục sản phẩm',
          style: AppStyle.bold(color: Colors.white, fontSize: 16),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              setState(() {
                isSearch = false;
              });
            });
          },
          child: Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white),
              child: const Icon(
                Icons.search_outlined,
                color: AppColors.primary,
                size: 20,
              )),
        ),
      ],
    );
  }

  Widget _buildTextField() {
    TextEditingController searchText = TextEditingController();
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isSearch = true;
            });

          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 24,
            color: Colors.white,
          ),
        ),
        const Gap(8),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 46,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: TextFormField(
            controller: searchText,
            readOnly: false,
            maxLines: 1,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              border: InputBorder.none,
              filled: true,
              errorStyle: TextStyle(height: 0),
              hintText: 'Tìm kiếm ...',
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.primary,
              ),
              contentPadding: EdgeInsets.all(12),
            ),
            onChanged: (value) async {
              // _searchUsers(value);
            },
          ),
        )
      ],
    );
  }
  Widget _widgetUser(
      String avatar,
      String id_item,
      String name_item,
      String type_item,
      String count_item,
      String pice_item,
      String status_item,

  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            
              borderRadius: BorderRadius.circular(100),
            image: DecorationImage(
              image: NetworkImage('$avatar')
            )
          ),
        ),
        const Gap(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mã sản phẩm: $id_item',
              style: AppStyle.medium(fontSize: 14)
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            Text(
              'Tên sản phẩm: $name_item',
              style: AppStyle.medium(fontSize: 14)
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            Text(
              'Loại sản phẩm: $type_item',
              style: AppStyle.medium(fontSize: 14)
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            Text(
              'Số lượng có: $count_item',
              style: AppStyle.medium(fontSize: 14)
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            Text(
              'Đơn giá: $pice_item',
              style: AppStyle.medium(fontSize: 14)
                  .copyWith(fontWeight: FontWeight.w500),
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
                    count_item == '0' ? 'Hết hàng':'Còn hàng',
                    style: AppStyle.regular(
                        fontSize: 13, color: count_item == '0'? Colors.red:Colors.green),
                  ),
                ),
              ],
            ),

          ],
        )
      ]),
    );
  }
}
