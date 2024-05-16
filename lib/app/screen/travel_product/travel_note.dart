import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';

import '../../core/values/colors.dart';
import '../../core/values/strings.dart';

class TravelNote extends StatefulWidget {
  final List<Map<String, dynamic>> selectedProducts;
  final int totalSelectedCount;
  final double totalValue;
  const TravelNote({super.key,required this.selectedProducts,required this.totalSelectedCount,required this.totalValue,});

  @override
  State<TravelNote> createState() => _TravelNoteState();
}

class _TravelNoteState extends State<TravelNote> {
  final TextEditingController nameShop = TextEditingController();
  final TextEditingController locationShop = TextEditingController();
  final TextEditingController namePeople = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
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
              Text('Tạo phiếu xuất hàng',style: AppStyle.bold(color: Colors.white),),
              IconButton(onPressed: (){}, icon: Icon(Icons.apps,color: Colors.white,))
            ],
          ),
        ),
        body: ListView(
          children: [

            // Padding(
            //   padding: const EdgeInsets.all(12),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text('Số lượng xuất: ${widget.totalSelectedCount.abs()}',style: AppStyle.medium(
            //         fontSize: 16,
            //       ),),
            //       Text('Tổng tiền: ${widget.totalValue.abs().toStringAsFixed(2)}',style: AppStyle.medium(
            //         fontSize: 16,
            //       ),),
            //       Gap(22),
            //       _buildTextField('Tên đại lý', nameShop),
            //       Gap(22),
            //       _buildTextField('Địa chỉ đại lý', locationShop),
            //       Gap(22),
            //       _buildTextField('Tên người nhận', namePeople),
            //       Gap(10),
            //       Text(
            //         'Chọn ngày',
            //         style: AppStyle.medium(
            //           fontSize: 16,
            //         ),
            //       ),
            //       GestureDetector(
            //         onTap: (){
            //           _selectDate(context);
            //         },
            //         child: Container(
            //           width: MediaQuery.of(context).size.height,
            //           padding: EdgeInsets.symmetric(vertical: 12,horizontal: 12),
            //
            //           decoration: BoxDecoration(
            //             border: Border.all(color: Colors.grey),
            //             borderRadius: BorderRadius.circular(5)
            //           ),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text(
            //                 "${selectedDate.toLocal()}".split(' ')[0],
            //                 style: AppStyle.regular(),
            //               ),
            //               Icon(Icons.keyboard_arrow_down)
            //             ],
            //           ),
            //         ),
            //       ),
            //
            //       Gap(25),
            //
            //     ],
            //   ),
            // ),
            GestureDetector(
                onTap: (){
                },
                child: GestureDetector(
                  onTap: (){

                  },
                  child: Container(
                    height: 55,
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Text('Tạo phiếu xuất',style: AppStyle.bold(color: Colors.red),),
                    ),
                  ),
                )
            ),
            Gap(33),
          ],
        )
    );
  }
  Widget _buildTextField(String title,TextEditingController name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyle.medium(
            fontSize: 16,
          ),
        ),
        const Gap(8),
        Container(
          width: MediaQuery.of(context).size.height,
          child: TextField(
            controller: name,
            maxLines: 1,
            decoration: const InputDecoration(
              errorStyle: TextStyle(height: 0),
              contentPadding: EdgeInsets.all(10),
              border: OutlineInputBorder(
              ),
            ),
          ),
        )
      ],
    );
  }
}
