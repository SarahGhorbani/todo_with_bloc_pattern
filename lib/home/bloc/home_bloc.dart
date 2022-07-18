import 'dart:async';

import 'package:todo_with_bloc_pattern/model/task.dart';
import 'package:todo_with_bloc_pattern/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final _repository = Repository();
  late final _tasks = BehaviorSubject<List<Task>>();
  late final _isAddCompleted = BehaviorSubject<bool>();

  Stream<List<Task>> get taskStream => _tasks.stream;
  Stream<bool> get isAddCompletedStream => _isAddCompleted.stream;

  void setTasks(value) {
    _tasks.value = value;
  }

  void setIsAddCompleted(value) {
    _isAddCompleted.value = value;
  }

  HomeBloc();

  Future<void> initValues() async {
    await _repository.init().then((value) => getTasks());
  }

  void getTasks() {
    List<Task> tasks = _repository.getTasks();
    setTasks(tasks);
  }

  void addTask(String title, String description) {
    setIsAddCompleted(false);
    _repository
        .addTask(title, description)
        .then((value) => setIsAddCompleted(true));
  }
}
