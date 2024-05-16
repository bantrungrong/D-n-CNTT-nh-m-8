

import 'package:drink_app_getx/app/core/values/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/values/strings.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class DetailBox extends StatefulWidget {
  final String name;
  final String company;
  final String location;
  final String time;
  final String monday;
  const DetailBox({super.key,required this.company,required this.location,required this.time,required this.name,required this.monday});

  @override
  State<DetailBox> createState() => _DetailBoxState();
}

class _DetailBoxState extends State<DetailBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 122,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color:
            Colors.grey.withOpacity(0.5), // Màu của bóng và độ trong suốt
            spreadRadius: 5, // Độ lan rộng của bóng
            blurRadius: 12, // Độ mờ của bóng
            offset: const Offset(0, 3), // Vị trí của bóng (theo trục X, Y)
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(100)),
          ),
          Row(children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: Get.width*0.15,
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(

                      children: [
                        Text(
                          widget.monday,
                          style: AppStyle.bold(color: Colors.white,fontSize: 13),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          height: 0.5,
                          width: 41,
                          color: Colors.white,
                        ),
                        Text(
                          widget.time,
                          style: AppStyle.medium(
                              color: Colors.white, fontSize: 13),
                        ),
                      ]),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  height: 21,
                  width: Get.width*0.15+10,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(MyImage.frame),
                          fit: BoxFit.fill)),
                ),
              ],
            ),
            const Gap(12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: AppStyle.bold(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(6),
                Row(
                  children: [
                    Container(
                      height: 16,
                      width: 16,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image:
                            AssetImage(MyImage.frame),
                            fit: BoxFit.cover),
                      ),
                    ),
                    const Gap(6),
                    Text(
                      widget.company,
                      style: AppStyle.medium(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
                const Gap(6),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const Gap(6),
                    Text(
                      widget.location,
                      style: AppStyle.medium(fontSize: 11, color: Colors.grey),
                    ),
                  ],
                ),
                const Gap(6),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_outlined,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const Gap(6),
                    SizedBox(
                      width: 195,
                      child: Text(
                        widget.time,
                        style:
                        AppStyle.medium(fontSize: 11, color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ]),
        ],
      ),
    );
  }
}
