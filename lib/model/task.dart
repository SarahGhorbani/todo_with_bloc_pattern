import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject{
  @HiveField(0)
  final String task;
  @HiveField(1)
  final bool completed;

  Task( this.task, this.completed);
}