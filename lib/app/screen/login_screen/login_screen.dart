import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import '../../core/values/colors.dart';
import '../../core/values/icons.dart';
import '../../core/values/strings.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../widget/button.dart';
import '../home_page/home_page_logined.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController company = TextEditingController();
  bool isContainerVisible = false;

  void toggleContainerVisibility() {
    setState(() {
      isContainerVisible = !isContainerVisible;
    });
  }

  ///
  bool signUp = false;
  Future<void> insertRecord() async {
    if (name.text != "" &&
        email.text != "" &&
        password.text != "" &&
        company.text != "") {
      try {
        String uri = "http://192.168.1.5/practice_api/insert_record.php";
        var res = await http.post(Uri.parse(uri), body: {
          "TenDangNhap": name.text,
          "MatKhau": password.text,
          "Congty": company.text,
          "email": email.text,
        });
        var reponse = jsonDecode(res.body);
        if (reponse["success"] == "true") {
          Fluttertoast.showToast(msg: 'Thêm thành công');
        } else {
          print("some issue");
        }
      } catch (e) {
        print(e);
      }
    } else
      Fluttertoast.showToast(msg: 'Nhập đầy đủ thông tin mới thêm');
  }

  /// đăng nhập
  String message = '';

  Future<void> login() async {
    final response = await http.post(
      Uri.parse('http://192.168.1.5/practice_api/login_data.php'),
      body: {
        'TenDangNhap': name.text,
        'MatKhau': password.text,
        'Congty': company.text,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);

      for (var user in responseData) {
        if (user['TenDangNhap'] == name.text &&
            user['MatKhau'] == password.text) {
          // Đăng nhập thành công, chuyển sang màn hình khác
          Get.to(const HomePageScreenLogined(), arguments: {
            'arg1': user['TenDangNhap'],
            'arg2': user['Congty'],
            'arg3': user['ChucVu'],
            'arg4': user['MatKhau'],
            'arg5': user['email'],
            'arg6': user['AnhDaiDien'],
            'arg7': user['QueQuan'],
          });
          return;
        }
      }

      // Nếu không tìm thấy tên người dùng và mật khẩu trong dữ liệu trả về
      setState(() {
        message = 'Tên người dùng hoặc mật khẩu không đúng';
      });
    } else {
      setState(() {
        message = 'Error: ${response.statusCode}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            color: Colors.red.shade50,
            image: const DecorationImage(
              image: AssetImage(MyImage.back_ground),
            )),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [_buildBody(context)],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      height: 36,
                      width: 36,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(100)),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: AppColors.primary,
                      )),
                ),
                const Gap(100),
                const Text(
                  'Đăng nhập',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const Gap(8),
                Text(
                  'Vui lòng đăng nhập tài khoản để tiếp tục',
                  style: AppStyle.regular(fontSize: 14, color: Colors.grey),
                ),
                const Gap(20),
                _buildTextFieldUserName(),
                const Gap(10),
                isContainerVisible ? _buildTextFieldCompany() : Container(),
                const Gap(10),
                isContainerVisible ? _buildTextFieldEmail() : Container(),
                const Gap(10),
                _buildTextFieldPassword(),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  TextButton(
                    onPressed: () {
                      toggleContainerVisibility();
                    },
                    child: RichText(
                      text: TextSpan(
                        text: isContainerVisible ? 'Đăng nhập' : 'Đăng ký',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  )
                ]),
                GestureDetector(
                  onTap: () {
                    // if(formKey.currentState!.validate()){
                    //   validateUser();
                    // }

                    isContainerVisible ? insertRecord() : login();
                  },
                  child: ButtonApp(
                      height: 50,
                      width: Get.width * 0.9,
                      title: isContainerVisible ? 'Đăng ký' : 'Đăng nhập',
                      color: Colors.red,
                      colorTitle: Colors.white),
                )
              ],
            ),
            const Gap(24)
          ]),
    );
  }

  Widget _buildTextFieldUserName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tên đăng nhập',
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

  Widget _buildTextFieldEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: AppStyle.medium(
            fontSize: 14,
          ),
        ),
        const Gap(8),
        SizedBox(
          width: MediaQuery.of(context).size.height,
          child: TextFormField(
            controller: email,
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

  Widget _buildTextFieldCompany() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tên Công ty',
          style: AppStyle.medium(
            fontSize: 14,
          ),
        ),
        const Gap(8),
        SizedBox(
          width: MediaQuery.of(context).size.height,
          child: TextFormField(
            controller: company,
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

  Widget _buildTextFieldPassword() {
    bool passwordVisible = false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mật khẩu ',
          style: AppStyle.medium(
            fontSize: 14,
          ),
        ),
        const Gap(8),
        SizedBox(
          width: MediaQuery.of(context).size.height,
          child: TextFormField(
            controller: password,
            readOnly: false,
            maxLines: 1,
            obscureText: !passwordVisible,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
                errorStyle: const TextStyle(height: 0),
                contentPadding: const EdgeInsets.all(10),
                suffixIcon: IconButton(
                  icon: Icon(
                    !passwordVisible
                        ? Icons.visibility_outlined
                        // ignore: dead_code
                        : Icons.visibility_off_outlined,
                    color: Colors.grey.shade700,
                    size: 22,
                  ),
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                )),
          ),
        )
      ],
    );
  }
}
