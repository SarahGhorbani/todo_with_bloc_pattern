import 'package:hive/hive.dart';

import '../model/task.dart';

class Repository {
  late Box<Task> _tasks;

  Future<void> init() async {
    Hive.registerAdapter(TaskAdapter());
    _tasks = await Hive.openBox<Task>('tasks');

    await _tasks.clear();

    await _tasks.add(Task('task1', 'desc1', true));
    await _tasks.add(Task('task2', 'desc2', false));
  }

  List<Task> getTasks() {
    final tasks = _tasks.values;
    return tasks.toList();
  }

  void addTask(final String title, String description) {
    _tasks.add(Task(title, description, false));
  }

  Future<void> removeTask(final String title) async {
    final taskToRemove =
        _tasks.values.firstWhere((element) => element.title == title);
    await taskToRemove.delete();
  }

  Future<void> updateTask(final String title, final String description) async {
    final taskToEdit =
        _tasks.values.firstWhere((element) => element.title == title);
    final index = taskToEdit.key as int;
    await _tasks.put(index, Task(title, description, !taskToEdit.isDone));
  }
}
