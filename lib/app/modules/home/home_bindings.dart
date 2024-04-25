


import '../../data/providers/task/provider.dart';
import '../../data/services/storage/reponsitory.dart';
import 'home_controller.dart';
import 'package:get/get.dart';
class HomeBinding implements Bindings {
  @override
  void dependencies () {
    Get.lazyPut(() => HomeController(
        taskReponsitory: TaskReponsitory(
          taskProvider: TaskProvider()
        ),

    ));
  }
}