import 'package:hive/hive.dart';

import '../model/tag/tag.dart';
import '../model/task/task.dart';

class Repository {
  late Box<Task> _tasks;
  late Box<Tag> _tags;

  Future<void> init() async {
    Hive.registerAdapter(TaskAdapter());
    Hive.registerAdapter(TagAdapter());

    _tasks = await Hive.openBox<Task>('tasks');
    _tags = await Hive.openBox<Tag>('tags');

    inititFakeTasks();
    inititDefaultTags();
  }

  Future<void> inititFakeTasks() async {
    await _tasks.clear();

    await _tasks.add(Task(1, 'task1', 'desc1', true,
        tags: [Tag(1, 'work'), Tag(2, 'sleep'), Tag(3, 'rest')]));
    await _tasks.add(Task(2, 'task2', 'desc2', false, tags: [
      Tag(4, 'food'),
      Tag(2, 'sleep'),
      Tag(5, 'study'),
      Tag(6, 'shopping')
    ]));
  }

  Future<void> inititDefaultTags() async {
    await _tags.clear();

    await _tags.add(Tag(1, 'work'));
    await _tags.add(Tag(2, 'sleep'));
    await _tags.add(Tag(3, 'rest'));
    await _tags.add(Tag(4, 'food'));
    await _tags.add(Tag(5, 'study'));
    await _tags.add(Tag(6, 'shopping'));
  }

  List<Task> getTasks() {
    final tasks = _tasks.values;
    return tasks.toList();
  }

  List<Tag> getTags() {
    final tags = _tags.values;
    return tags.toList();
  }

  Future<void> addTask(final String title, String description) async {
    int id = _tasks.length + 1;
    await _tasks.add(Task(id, title, description, false, tags: []));
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
