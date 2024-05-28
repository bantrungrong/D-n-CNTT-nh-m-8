import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController {
  var selected = 0.obs;
  var users = <Map<String, dynamic>>[].obs;
  var filteredUsers = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    getRecord();
    ever(selected, (_) => filterUsers());
  }

  void getRecord() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.1.12/practice_api/view_data.php'));
      if (response.statusCode == 200) {
        users.value =
            List<Map<String, dynamic>>.from(jsonDecode(response.body));
        filterUsers();
      } else {
        print('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void filterUsers() {
    if (selected.value == 0) {
      filteredUsers.value = users;
    } else if (selected.value == 1) {
      filteredUsers.value =
          users.where((user) => user['SoLuongTon'] == '0').toList();
    } else if (selected.value == 2) {
      filteredUsers.value =
          users.where((user) => user['SoLuongTon'] != '0').toList();
    }
  }

  void setSelected(int index) {
    selected.value = index;
  }
}
