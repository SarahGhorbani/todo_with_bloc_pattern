import 'package:hive/hive.dart';
part 'tag.g.dart';

@HiveType(typeId: 2)
class Tag extends HiveObject{
  @HiveField(0)
  final int id;
  @HiveField(1)
  late String title;

  Tag(this.id, this.title);
}
