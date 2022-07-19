import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:todo_with_bloc_pattern/model/task.dart';
import 'package:todo_with_bloc_pattern/repository/repository.dart';

class HomeBloc {
  final _repository = Repository();
  late final _tasks = BehaviorSubject<List<Task>>();
  late final _remainingTask = BehaviorSubject<List<Task>>();
  late final _isAddCompleted = BehaviorSubject<bool>();

  Stream<List<Task>> get taskStream => _tasks.stream;
  List<Task> get tasksValue => _tasks.value;
  Stream<List<Task>> get remainingTaskStream => _remainingTask.stream;
  Stream<bool> get isAddCompletedStream => _isAddCompleted.stream;

  void setTasks(value) {
    _tasks.value = value;
  }

  void setIsAddCompleted(value) {
    _isAddCompleted.value = value;
  }

  void setRemainingTasks(value) {
    _remainingTask.value = value;
  }

  HomeBloc();

  Future<void> initValues() async {
    await _repository.init().then((value) => getTasks());
  }

  void getTasks() {
    List<Task> tasks = _repository.getTasks();
    setTasks(tasks);
    getRemainingTasks();
  }

  void addTask(String title, String description) {
    setIsAddCompleted(false);
    _repository.addTask(title, description).then((value) => onTaskAdded());
  }

  void onTaskAdded() {
    setIsAddCompleted(true);
    getTasks();
  }

  void updateTask(Task task) {
    _repository.updateTask(task).then((value) => onTaskAdded());
  }

  void doneTask(Task task) {
    _repository.updateTask(task).then((value) => getTasks());
  }

  void removeTask(int id) {
    _repository.removeTask(id).then((value) => getTasks());
  }

  void getRemainingTasks() {
    List<Task> remaining = [];
    for(int i=0;i<tasksValue.length;i++){
      if(tasksValue[i].isDone == false){
        remaining.add(tasksValue[i]);
      }
      setRemainingTasks(remaining);
    }
  }

  void dispose() {
    _tasks.close();
    _isAddCompleted.close();
    _remainingTask.close();
  }
}
