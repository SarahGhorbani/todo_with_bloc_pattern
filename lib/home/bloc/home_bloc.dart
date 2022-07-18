import 'dart:async';

import 'package:todo_with_bloc_pattern/model/task.dart';
import 'package:todo_with_bloc_pattern/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final _repository = Repository();
  late final _tasks = BehaviorSubject<List<Task>>();

  Stream<List<Task>> get taskStream => _tasks.stream;

  void setTasks(value) {
    _tasks.value = value;
  }

  HomeBloc();

  Future<void> initValues() async {
    await _repository.init().then((value) => getTasks());
  }

  void getTasks() {
    List<Task> tasks = _repository.getTasks();
    setTasks(tasks);
  }
}
