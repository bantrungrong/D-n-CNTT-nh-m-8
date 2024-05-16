  import 'dart:convert';
import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
  import 'package:get/get.dart';
  import 'package:gap/gap.dart';
  import 'package:http/http.dart' as http;
import '../../core/values/colors.dart';
import '../../core/values/strings.dart';
  import 'package:fluttertoast/fluttertoast.dart';
  import 'package:fluttertoast/fluttertoast.dart';


  class SelectedProductScreen extends StatefulWidget {
    final List<Map<String, dynamic>> selectedProducts;
    final int totalSelectedCount;
    final double totalValue;
    const SelectedProductScreen({super.key,required this.selectedProducts,required this.totalSelectedCount,required this.totalValue,});

    @override
    State<SelectedProductScreen> createState() => _SelectedProductScreenState();
  }

  class _SelectedProductScreenState extends State<SelectedProductScreen> {
    // final TextEditingController tenDaiLy   = TextEditingController();
    // final TextEditingController locationShop = TextEditingController();
    // final TextEditingController countItem = TextEditingController();
    // final TextEditingController idProduct = TextEditingController();
    // final TextEditingController nameShop = TextEditingController();
    final TextEditingController namePeople = TextEditingController();
    final TextEditingController id = TextEditingController();
    final TextEditingController namepro = TextEditingController();
    final TextEditingController count = TextEditingController();
    final TextEditingController type = TextEditingController();
    final TextEditingController pice = TextEditingController();
    final TextEditingController count_item = TextEditingController();
    final TextEditingController output_count = TextEditingController();
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();
    List<Map<String, dynamic>> users = [];
    var selectedMaDaiLy = ''.obs;
    var selectedTendaiLy = ''.obs;
    var selectedDiaChi = ''.obs;
    var selectedSDT = ''.obs;
    void updateSelectedCompany(String Madaily, String Tendaily, String DiaChi, String SDT) {
      selectedMaDaiLy.value = Madaily;
      selectedTendaiLy.value = Tendaily;
      selectedDiaChi.value = DiaChi;
      selectedSDT.value = SDT;
    }
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
    void initState() {
      super.initState();
      getRecord();
    }
    Future<void> getRecord() async {
      try {
        final response = await http.get(Uri.parse('http://192.168.160.249/practice_api/TT_daily.php'));
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

    Future<void> insertPhieuXuat()async{
      if(
      id.text != ''
      )
      {
        try{
          String uri = "http://192.168.160.249/practice_api/add_phieu_xuat.php";

            var res = await http.post(Uri.parse(uri),body: {
              "MaPhieuXuat": id.text,
              "MaSanPham": '1',
              "MaDaiLy": selectedMaDaiLy.value,
              "count_item": output_count.text,
              "NgayXuat": selectedDate.toIso8601String(),
              "DonGia": '22',
              "TenSanPham": widget.selectedProducts.toString(),
              "TenDaiLy": 'ad',
              "DiaChi": selectedDiaChi.value,
              "SoDienThoai": selectedSDT.value,
              "NguoiNhan": namePeople.text,
              "TongTien": '${widget.totalValue.abs().toStringAsFixed(2)}',
              "TongSP": '${widget.totalSelectedCount.abs()}',
            });
            var reponse = jsonDecode(res.body);
            if(reponse["success"]=="true"){
              Fluttertoast.showToast(msg: 'Thêm thành công');
            }
            else{
              print("some issue");
            }

        } catch (e) {
          print(e);
        }
      }
      else Fluttertoast.showToast(msg: 'Nhập đầy đủ thông tin mới thêm');
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
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text('Sản phẩm đã chọn',style: AppStyle.bold(),),
            ),
            Container(
              height: Get.height*0.4,
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(12)
              ),

              child: Container(child: ListView.builder(
                itemCount: widget.selectedProducts.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(bottom: 10),
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.4,color: Colors.black)
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Mã SP: ${widget.selectedProducts[index]['MaSanPham']}',style: AppStyle.medium(fontSize: 14)),
                            Text('Tên SP: ${widget.selectedProducts[index]['TenSanPham']}',style: AppStyle.medium(fontSize: 14)
                                .copyWith(fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,),
                            Text(
                              'Đơn giá: ${widget.selectedProducts[index]['DonGia']}',
                              style: AppStyle.medium(fontSize: 14)
                                  .copyWith(fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Số lượng sản phẩm: ${widget.selectedProducts[index]['count_item']}',
                              style: AppStyle.medium(fontSize: 14)
                                  .copyWith(fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),

                      ],
                    ),
                  );
                },
              ),),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Số lượng sản phẩm đã chọn: ${widget.totalSelectedCount.abs()}',style: AppStyle.medium(
                    fontSize: 16,
                  ),),
                  // Text('Tổng tiền: ${widget.totalValue.abs().toStringAsFixed(2)}',style: AppStyle.medium(
                  //   fontSize: 16,
                  // ),),
                  Gap(10),
                  Text('Nhập thông tin',style: AppStyle.bold(),),
                  Gap(10),
                  _buildTextField('Nhập số lượng xuất', output_count),
                  Gap(10),
                  _buildTextField('Nhập mã phiếu xuất', id),
                  Gap(10),
                  Text('Chọn đại lý', style: AppStyle.medium(fontSize: 16,),),
                  Gap(10),
                  GestureDetector(
                    onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              title: Text('Chọn công ty'),
                              // insetPadding: const EdgeInsets.all(25),
                              content: Container(
                                height: Get.height*0.8,
                                width: Get.width*0.9,
                                child: ListView.builder(
                                  itemCount: users.length,
                                  itemBuilder: (context,index){
                                    return GestureDetector(
                                      onTap: (){
                                        updateSelectedCompany(users[index]['MaDaiLy'],users[index]['TenDaiLy'],users[index]['DiaChi'],users[index]['SoDienThoai'], );
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(width: 1,color: Colors.black)
                                            )
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [Text('Mã đại lý ${users[index]['MaDaiLy']}',overflow: TextOverflow.ellipsis,),
                                            Text('Tên đại lý: ${users[index]['TenDaiLy']}',overflow: TextOverflow.ellipsis,),
                                            Text('Địa chỉ: ${users[index]['DiaChi']}',overflow: TextOverflow.ellipsis,),
                                            Text('Số điện thoại: ${users[index]['SoDienThoai']}',overflow: TextOverflow.ellipsis,),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            );
                          },
                        );
                      },
                    child: Container(
                      width: MediaQuery.of(context).size.height,
                      padding: EdgeInsets.symmetric(vertical: 12,horizontal: 12),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() => Container(
                            width: Get.width*0.7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  selectedMaDaiLy.isEmpty ? '' : 'Mã Đại Lý: ${selectedMaDaiLy.value}',
                                  style: TextStyle(fontSize: 15),overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  selectedTendaiLy.isEmpty ? '' : 'Tên đại lý: ${selectedTendaiLy.value}',
                                  style: TextStyle(fontSize: 15),overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  selectedDiaChi.isEmpty ? '' : 'Địa chỉ: ${selectedDiaChi.value}',
                                  style: TextStyle(fontSize: 15),overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  selectedSDT.isEmpty ? '' : 'Số điện thoại: ${selectedSDT.value}',
                                  style: TextStyle(fontSize: 15),overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          )),
                          Icon(Icons.keyboard_arrow_down)
                        ],
                      ),
                    ),
                  ),
                  Gap(22),
                  _buildTextField('Tên người nhận', namePeople),
                  Gap(10),
                  Text(
                    'Chọn ngày',
                    style: AppStyle.medium(
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      _selectDate(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.height,
                      padding: EdgeInsets.symmetric(vertical: 12,horizontal: 12),

                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${selectedDate.toLocal()}".split(' ')[0],
                            style: AppStyle.regular(),
                          ),
                          Icon(Icons.keyboard_arrow_down)
                        ],
                      ),
                    ),
                  ),

                  Gap(25),

                ],
              ),
            ),
            GestureDetector(
                onTap: (){

                },
                child: GestureDetector(
                  onTap: (){
                    if(int.parse(output_count.text) < widget.totalSelectedCount.abs())
                      {
                        Fluttertoast.showToast(msg: 'Số lượng xuất không hợp lệ');
                      } else insertPhieuXuat();

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
