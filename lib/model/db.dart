import 'package:hive/hive.dart';

part 'db.g.dart';

@HiveType(typeId: 0)
class Db extends HiveObject {
  @HiveField(0)
  late String imagepath;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late int number;

  Db({required this.imagepath, required this.name, required this.number});
}
