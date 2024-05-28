import 'dart:async';
import 'dart:convert';

import 'package:drink_app_getx/app/core/values/icons.dart';
import 'package:drink_app_getx/app/screen/input_product/input_product.dart';
import 'package:drink_app_getx/app/screen/report/home_report.dart';
// import 'package:drink_app_getx/app/screen/product/product_detail.dart';
import 'package:drink_app_getx/app/screen/report/report_screen.dart';
import 'package:drink_app_getx/app/screen/shop/shop.dart';
import 'package:drink_app_getx/app/screen/user/user_screen.dart';
import 'package:drink_app_getx/app/widget/widget_detail_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import '../../core/values/strings.dart';
import '../factory/factory_screen.dart';
import '../home_page_guest.dart/home_page_guest.dart';
import '../noti_screen/noti_screeen.dart';
import '../product/product.dart';
import '../travel_product/travel_ticket.dart';
import 'home_page.dart';
import 'package:http/http.dart' as http;

class HomePageScreenLogined extends StatefulWidget {
  const HomePageScreenLogined({super.key});

  @override
  State<HomePageScreenLogined> createState() => _HomePageScreenLoginedState();
}

class _HomePageScreenLoginedState extends State<HomePageScreenLogined> {
  late String arg1;
  late String arg2;
  late String arg3;
  late String arg4;
  late String arg5;
  late String arg6;
  late String arg7;
  final selectedIndex = RxInt(0);
  final List<IconData> selectedIcons = [
    Icons.home,
    Icons.notification_add,
    Icons.person,
  ];
  final List<IconData> unselectedIcons = [
    Icons.home_outlined,
    Icons.notifications,
    Icons.person_outline,
  ];
  final List<Widget> widgetOptions = <Widget>[
    const HomePageScreen(),
    const NotiScreen(),
    const HomePageGuest(),
  ];
  List<Map<String, dynamic>> product = [];
  Future<void> getRecord() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.160.249/practice_api/view_data.php'));
      if (response.statusCode == 200) {
        setState(() {
          product = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        });
      } else {
        print('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments;
    if (arguments != null) {
      arg1 = arguments['arg1'] ?? '';
      arg2 = arguments['arg2'] ?? '';
      arg3 = arguments['arg3'] ?? '';
      arg4 = arguments['arg4'] ?? '';
      arg5 = arguments['arg5'] ?? '';
      arg6 = arguments['arg6'] ?? '';
      arg7 = arguments['arg7'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: Get.height * 0.1,
        backgroundColor: Colors.red,
        title: Row(children: [
          GestureDetector(
            onTap: () {
              Get.to(UserScreen(
                nameCom: arg2,
                idUser: arg1,
                tier: arg3,
                PasWord: arg4,
                email: arg5,
                avatar: arg6,
                country: arg7,
              ));
            },
            child: Row(
              children: [
                Container(
                  height: 66,
                  width: 66,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white),
                  child: Image.network('${arg6}'),
                ),
                const Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tên người dùng: $arg1',
                      style: AppStyle.bold(fontSize: 13, color: Colors.white),
                    ),
                    Text(
                      'Công ty : $arg2',
                      style: AppStyle.bold(fontSize: 15, color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ),
        ]),
      ),
      body: ListView(
        children: [_buildBodyContent()],
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(selectedIndex.value == 0
                    ? selectedIcons[0]
                    : unselectedIcons[0]),
                label: 'Trang chủ',
              ),
              BottomNavigationBarItem(
                icon: Icon(selectedIndex.value == 1
                    ? selectedIcons[1]
                    : unselectedIcons[1]),
                label: 'Thông báo',
              ),
              BottomNavigationBarItem(
                icon: GestureDetector(
                  onTap: () {
                    Get.to(UserScreen(
                        idUser: arg1,
                        nameCom: arg2,
                        tier: arg3,
                        PasWord: arg4,
                        email: arg5,
                        avatar: arg6,
                        country: arg7));
                  },
                  child: Icon(selectedIndex.value == 2
                      ? selectedIcons[2]
                      : unselectedIcons[2]),
                ),
                label: 'Cá nhân',
              ),
            ],
            currentIndex: selectedIndex.value,
            onTap: (index) {
              selectedIndex.value = index;
            },
            fixedColor: Colors.red,
          )),
    );
  }

  String getGreeting(int hour) {
    if (hour >= 0 && hour < 12) {
      return 'Xin chào buổi sáng $arg1 !';
    } else if (hour >= 12 && hour < 18) {
      return 'Xin chào buổi chiều $arg1!';
    } else {
      return 'Xin chào buổi tối $arg1!';
    }
  }

  Widget _buildBodyContent() {
    DateTime currentDate = DateTime.now();
    // Format ngày tháng năm sang chuỗi để hiển thị
    String formattedDate = "${currentDate.day}/${currentDate.month}";
    String dayOfWeek = getDayOfWeek(currentDate.weekday);
    DateTime now = DateTime.now();
    String greeting = getGreeting(now.hour);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(12),
        DetailBox(
          company: 'Công ty : $arg2',
          time: formattedDate,
          name: greeting,
          location: 'Địa chỉ: 123 ABC Street, City A',
          monday: dayOfWeek,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Text(
            'Danh mục',
            style: AppStyle.bold(
              fontSize: 18,
            ),
          ),
        ),
        Center(
          child: Wrap(
            spacing: 20,
            runSpacing: 10,
            children: [
              GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, ProductScreen() );
                    Get.to(ProductScreen());
                  },
                  child:
                      _buildCell('Quản lý danh mục sản phẩm', MyIcon.product)),
              GestureDetector(
                  onTap: () {
                    Get.to(UserListScreen());
                  },
                  child: _buildCell('Quản lý thông tin đại lý', MyIcon.shop)),
              GestureDetector(
                  onTap: () {
                    Get.to(TicketTravel());
                  },
                  child: _buildCell('Quản lý xuất hàng', MyIcon.travel)),
              GestureDetector(
                  onTap: () {
                    Get.to(TicketInput());
                  },
                  child: _buildCell('Quản lý nhập hàng', MyIcon.take)),
              GestureDetector(
                  onTap: () {
                    Get.to(HomeReport());
                  },
                  child: _buildCell('Thống kê báo cáo', MyIcon.detail)),
              GestureDetector(
                  onTap: () {
                    Get.to(FactoryScreen());
                  },
                  child: _buildCell('Xưởng sản xuất', MyIcon.factory)),
            ],
          ),
        )
      ],
    );
  }

  String getDayOfWeek(int day) {
    switch (day) {
      case 1:
        return 'Thứ hai';
      case 2:
        return 'Thứ ba';
      case 3:
        return 'Thứ tư';
      case 4:
        return 'Thứ năm';
      case 5:
        return 'Thứ sáu';
      case 6:
        return 'Thứ bảy';
      case 7:
        return 'Chủ nhật';
      default:
        return '';
    }
  }

  Widget _buildCell(String data, String icon) {
    return Container(
      height: Get.width / 3 - 20,
      width: Get.width / 3 - 20,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 2), // changes the direction of shadow
          ),
        ],
      ),
      child: Column(children: [
        Container(
          height: 23,
          width: 23,
          decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(image: AssetImage(icon))),
        ),
        const Gap(5),
        Text(
          data,
          style: AppStyle.bold(fontSize: 12, color: Colors.red),
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }
}
