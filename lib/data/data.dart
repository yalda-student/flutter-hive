import 'package:hive_flutter/adapters.dart';

part 'data.g.dart';

@HiveType(typeId: 0)
class Student extends HiveObject {
  int id = -1;
  @HiveField(0)
  String firstName = '';
  @HiveField(1)
  String lastName = '';
  @HiveField(2)
  List<Course> courses = [];

  @override
  String toString() {
    return '{id = $id, first-name = $firstName, last-name = $lastName, courses = $courses}';
  }
}

@HiveType(typeId: 1)
class Course extends HiveObject {
  int id = -1;
  @HiveField(0)
  String name = '';

  @override
  String toString() {
    return '{id = $id, name = $name}';
  }
}
