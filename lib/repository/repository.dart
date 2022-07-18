import 'package:hive/hive.dart';

import '../model/task.dart';

class Repository{
  late Box<Task> _tasks;

  Future<void> init() async{
    Hive.registerAdapter(TaskAdapter());
    _tasks =await Hive.openBox<Task>('tasks');
  }

  List<Task> getTasks() {
    final tasks = _tasks.values;
    return tasks.toList();
  }

  void addTask(final String task) {
    _tasks.add(Task( task, false));
  }

  Future<void> removeTask(final String task) async {
    final taskToRemove = _tasks.values.firstWhere((element) => element.task == task);
    await taskToRemove.delete();
  }

  Future<void> updateTask(final String task, final String username) async {
    final taskToEdit = _tasks.values.firstWhere((element) => element.task == task);
    final index = taskToEdit.key as int;
    await _tasks.put(index, Task(task, !taskToEdit.completed));
  }
}