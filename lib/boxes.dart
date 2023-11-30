import 'package:diali/model/db.dart';
import 'package:hive/hive.dart';

class Boxes {
  static Box<Db> getContacts() => Hive.box<Db>("contacts");
  static Box getValues() => Hive.box("values");
}
