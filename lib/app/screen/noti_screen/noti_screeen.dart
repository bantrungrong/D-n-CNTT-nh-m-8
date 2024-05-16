import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../core/values/strings.dart';

class NotiScreen extends StatefulWidget {
  const NotiScreen({super.key});

  @override
  State<NotiScreen> createState() => _NotiScreenState();
}

class _NotiScreenState extends State<NotiScreen> {
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    getRecord();
  }

  Future<void> getRecord() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.0.157/practice_api/view_data.php'));
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
  Widget _buildBodyContext(){
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context,index){
        return GestureDetector(
          onTap: (){

          },
          child: users[index]['count_item'] == '0'? Container(): Container(
              margin: EdgeInsets.symmetric(vertical: 6,horizontal: 6),
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
              // color: Colors.red,
              child:CheckboxListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${users[index]['TenSanPham']}',overflow: TextOverflow.ellipsis,),
                    Text('số lượng:${users[index]['count_item']}',style: AppStyle.regular(fontSize: 13),),
                  ],
                ),

                value: users[index]['isChecked'] ?? false,
                onChanged: (bool? value) {
                  setState(() {
                    users[index]['isChecked'] = value;
                  });
                },
              )
          ),
        );
      },
    );
  }
}
