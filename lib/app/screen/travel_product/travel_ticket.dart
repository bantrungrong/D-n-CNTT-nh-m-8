import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import '../../core/values/colors.dart';
import '../../core/values/strings.dart';
import '../../widget/button.dart';
import 'travel_product.dart';
class TicketTravel extends StatefulWidget {
  const TicketTravel({super.key});

  @override
  State<TicketTravel> createState() => _TicketTravelState();
}

class _TicketTravelState extends State<TicketTravel> {
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
            Text('Phiếu xuất hàng',style: AppStyle.bold(color: Colors.white),),
            IconButton(onPressed: (){}, icon: Icon(Icons.apps,color: Colors.white,))
          ],
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView.builder(
            itemCount: 12,
            itemBuilder: (context,index){
              return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

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
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: (){

                        },
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
              );
            },
          ),
          InkWell(
            onTap: (){
              Get.to(TravelProduct());
            },
              child: ButtonApp(height: 55, width: 200, title: 'Thêm phiếu xuất', color: Colors.white, colorTitle: Colors.red))
        ],
      ),
    );
  }
}
