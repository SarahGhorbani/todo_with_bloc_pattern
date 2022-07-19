import 'package:hive/hive.dart';
import 'package:todo_with_bloc_pattern/model/tag.dart';
part 'task.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject{
  @HiveField(0)
  final int id;
  @HiveField(1)
  late String title;
  @HiveField(2)
  late String description;
  @HiveField(3)
  late bool isDone;
  @HiveField(4)
  late List<Tag>? tags;


  Task(this.id, this.title,this.description, this.isDone,{required this.tags} );
}