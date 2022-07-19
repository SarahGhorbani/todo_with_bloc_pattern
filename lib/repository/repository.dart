import 'package:hive/hive.dart';

import '../model/task.dart';

class Repository {
  late Box<Task> _tasks;

  Future<void> init() async {
    Hive.registerAdapter(TaskAdapter());
    _tasks = await Hive.openBox<Task>('tasks');

    await _tasks.clear();

    await _tasks.add(Task(1,'task1', 'desc1', true));
    await _tasks.add(Task(2,'task2', 'desc2', false));
  }

  List<Task> getTasks() {
    final tasks = _tasks.values;
    return tasks.toList();
  }

  Future<void> addTask(final String title, String description) async {
    int id = _tasks.length +1;
    await _tasks.add(Task(id,title, description, false));
  }

  Future<void> removeTask(final int id) async {
    final taskToRemove =
        _tasks.values.firstWhere((element) => element.id == id);
    await taskToRemove.delete();
  }

  Future<void> updateTask(final Task task) async {
    final taskToEdit =
        _tasks.values.firstWhere((element) => element.id == task.id);
    final index = taskToEdit.key as int;
    await _tasks.put(index, task);
  }
}
