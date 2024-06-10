import 'package:drink_app_getx/app/core/values/strings.dart';
import 'package:drink_app_getx/app/screen/qr_code/qr_code_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';

class QRcodeScreen extends StatefulWidget {
  const QRcodeScreen({super.key});

  @override
  State<QRcodeScreen> createState() => _QRcodeScreenState();
}

class _QRcodeScreenState extends State<QRcodeScreen> {
  final TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: QrImage(
              data: name.text,
              version: QrVersions.auto,
              size: 200.0,
            ),
          ),
          _buildTextField('Nhập link sản phẩm', name),
          TextButton(onPressed: () {}, child: Text('Đồng ý')),
          Gap(12),
          GestureDetector(
            onTap: () {
              Get.to(QRViewExample);
            },
            child: Icon(Icons.camera),
          )
        ],
      ),
    );
  }

  Widget _buildTextField(String title, TextEditingController name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyle.medium(
            fontSize: 14,
          ),
        ),
        const Gap(8),
        SizedBox(
          width: MediaQuery.of(context).size.height,
          child: TextFormField(
            controller: name,
            readOnly: false,
            maxLines: 1,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: const InputDecoration(
              errorStyle: TextStyle(height: 0),
              contentPadding: EdgeInsets.all(10),
            ),
          ),
        )
      ],
    );
  }
}
