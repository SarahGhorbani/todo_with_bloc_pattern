import 'package:hive/hive.dart';

class Tag{
  @HiveField(0)
  final int id;
  @HiveField(1)
  late String title;

  Tag(this.id, this.title);
}