

import '../../models/task.dart';
import '../../providers/task/provider.dart';

class TaskReponsitory {
  TaskProvider taskProvider;
  TaskReponsitory ({required this.taskProvider});

  List<Task> readTask() =>  taskProvider.readTasks();
  void writeTask (List<Task> tasks) => taskProvider.writeTasks(tasks);
}