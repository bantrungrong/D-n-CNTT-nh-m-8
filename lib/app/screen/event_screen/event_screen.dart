

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/values/colors.dart';
import 'package:get/get.dart';

import '../../core/values/strings.dart';
import '../new_event_screen/new_event_screen.dart';
class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  int _currentIndex = 0;
  List<String> selectedIndex = [
    'Sắp diễn ra',
    'Đã diễn ra',
  ];
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
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.primary,
                  )),
            ),
            Text(
              'Sinh hoạt Đảng',
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
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          _buildEvent(),
          _buildCell(),
        ],
      ),
    );
  }

  Widget _buildEvent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            height: 40,
            decoration: BoxDecoration(
                color: const Color.fromRGBO(240, 240, 240, 1),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
                children: List.generate(
              2,
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.43,
                  height: 32,
                  decoration: BoxDecoration(
                      color: _currentIndex == index
                          ? Colors.white
                          : const Color.fromRGBO(240, 240, 240, 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: _currentIndex == index
                        ? Text(
                            selectedIndex[index],
                            style: AppStyle.bold(
                                color: Colors.black, fontSize: 13),
                          )
                        : Text(selectedIndex[index],
                            style: AppStyle.medium(
                                    color:
                                        const Color.fromRGBO(141, 141, 141, 1),
                                    fontSize: 13)
                                .copyWith(fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
            )),
          ),
        ),
      ],
    );
  }

  Widget _buildCell() {
    return Expanded(
      // height: MediaQuery.of(context).size.height * 0.85,
      // width: MediaQuery.of(context).size.width * 1,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 2,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(const NewEventScreen());
            },
            child: Container(
              height: Get.height * 0.2,
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset:
                        const Offset(0, 2), // changes the direction of shadow
                  ),
                ],
              ),
              child: Container(),
            ),
          );
        },
      ),
    );
  }
}
