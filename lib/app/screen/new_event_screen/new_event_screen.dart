

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/values/colors.dart';
import 'package:get/get.dart';

import '../../core/values/strings.dart';
class NewEventScreen extends StatefulWidget {
  const NewEventScreen({super.key});

  @override
  State<NewEventScreen> createState() => _NewEventScreenState();
}

class _NewEventScreenState extends State<NewEventScreen> {
  final List<String> urls = [
    'https://classroom.google.com/?hl=fr', // URL cho item 1
    'https://dangcongsan.vn/xay-dung-dang', // URL cho item 2
    'https://dangcongsan.vn/thoi-su/tang-cuong-phong-chong-nang-nong-han-han-thieu-nuoc-xam-nhap-man-662290.html',
  ];
  @override
  Widget build(BuildContext context) {
    bool isFavorite = true;
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
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.primary,
                    )),
              ),
              Text(
                'Chi tiết tin tức',
                style: AppStyle.bold(color: Colors.white, fontSize: 16),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white),
                    child: Icon(
                      isFavorite == true
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: Colors.red,
                    )),
              ),
            ],
          ),
        ),
        body: Container());
  }
}
