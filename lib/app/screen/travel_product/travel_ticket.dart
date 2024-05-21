import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../../core/values/colors.dart';
import '../../core/values/strings.dart';
import '../../widget/button.dart';
import 'add_ticket.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class TicketTravel extends StatefulWidget {
  const TicketTravel({super.key});

  @override
  State<TicketTravel> createState() => _TicketTravelState();
}

class _TicketTravelState extends State<TicketTravel> {
  List<Map<String, dynamic>> ticket = [];
  @override
  void initState() {
    super.initState();
    getRecordTTPhieuXuat();
  }

  Future<void> getRecordTTPhieuXuat() async {
    try {
      final responseTT = await http
          .get(Uri.parse('http://192.168.1.2/practice_api/TT_Phieuxuat.php'));
      if (responseTT.statusCode == 200) {
        setState(() {
          ticket = List<Map<String, dynamic>>.from(jsonDecode(responseTT.body));
        });
      } else {
        print('Failed to load users: ${responseTT.statusCode}');
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
            Text(
              'Phiếu xuất hàng',
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
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView.builder(
              itemCount: ticket.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(
                                  0, 2), // changes the direction of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Mã phiếu xuất: ${ticket[index]['MaPhieu']}',
                                      style: AppStyle.medium(fontSize: 14)
                                          .copyWith(
                                              fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'Mã đại lý: ${ticket[index]['MaDaiLy']}',
                                      style: AppStyle.medium(fontSize: 14)
                                          .copyWith(
                                              fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'Tên người nhận: ${ticket[index]['TenNguoiNhan']}',
                                      style: AppStyle.medium(fontSize: 14)
                                          .copyWith(
                                              fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'Ngày xuất: ${ticket[index]['NgayXuat']}',
                                      style: AppStyle.medium(fontSize: 14)
                                          .copyWith(
                                              fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                );
              }),
          InkWell(
              onTap: () {
                Get.to(AddTicket());
              },
              child: ButtonApp(
                  height: 55,
                  width: 200,
                  title: 'Thêm phiếu xuất',
                  color: Colors.white,
                  colorTitle: Colors.red))
        ],
      ),
    );
  }
}
