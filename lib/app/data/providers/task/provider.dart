
import 'dart:convert';

import 'package:get/get.dart';
import '../../../core/utils/keys.dart';
import '../../models/task.dart';
import '../../services/services.dart';

class TaskProvider{
  final _storage = Get.find<StorageService> ();

  List <Task> readTasks(){
    var tasks = <Task>[];
    jsonDecode(_storage.read(taskkey).toString())
        .forEach((e) => tasks.add(Task.fromJson(e)));
    return tasks;
  }
  void writeTasks (List<Task> tasks){
    _storage.write(taskkey, jsonEncode(tasks));
  }
}