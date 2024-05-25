import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../core/values/colors.dart';
import '../../core/values/strings.dart';
import '../../data/providers/task/provider.dart';
import '../../data/services/storage/reponsitory.dart';
import '../../screen/home_page/home_page.dart';
import '../../screen/home_page_guest.dart/home_page_guest.dart';
import '../../screen/login_screen/login_screen.dart';
import '../../screen/noti_screen/noti_screeen.dart';
import '../../widget/button.dart';
import 'home_controller.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController(
        taskReponsitory: TaskReponsitory(taskProvider: TaskProvider())));
    final selectedIndex = RxInt(0);
    final List<Widget> widgetOptions = <Widget>[
      const HomePageScreen(),
      const NotiScreen(),
      const HomePageGuest(),
    ];

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
    void _showDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: const Icon(
              Icons.account_circle_outlined,
              size: 50,
              color: AppColors.primary,
            ),
            insetPadding: const EdgeInsets.all(12),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Đăng nhập tài khoản',
                  style: AppStyle.bold(fontSize: 16),
                ),
                const Gap(6),
                Text(
                  'Đăng nhập vào tài khoản của bạn để sử dụng chức năng này',
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: AppStyle.regular(fontSize: 14, color: Colors.grey),
                ),
                const Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const ButtonApp(
                          height: 55,
                          width: 100,
                          title: 'Thoát',
                          colorTitle: Colors.red,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            Get.to(const LoginScreen());
                          },
                          child: const ButtonApp(
                            height: 55,
                            width: 100,
                            colorTitle: Colors.white,
                            title: 'Đăng nhập',
                            color: Colors.red,
                          )),
                    )
                  ],
                )
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Get.height * 0.1,
        backgroundColor: Colors.red,
        title: Row(children: [
          GestureDetector(
            onTap: (() {
              _showDialog(context);
            }),
            child: Container(
              height: 50,
              width: 130,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Center(
                  child: Text(
                'Đăng nhập',
                style: AppStyle.bold(fontSize: 16, color: Colors.red),
              )),
            ),
          ),
        ]),
      ),
      body: Obx(() => widgetOptions[selectedIndex.value]),
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
                icon: Icon(selectedIndex.value == 2
                    ? selectedIcons[2]
                    : unselectedIcons[2]),
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
}
