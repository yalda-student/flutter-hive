import 'package:flutter/cupertino.dart';
import 'package:flutter_application_test_hive/data/data.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DataSource {
  final Box<Student> studentBox;
  final Box<Course> courseBox;

  DataSource(this.studentBox, this.courseBox);

  Future<Student> addStudent(Student student) async {
    if (student.isInBox) {
      student.save();
    } else {
      student.id = await studentBox.add(student);
    }
    return student;
  }

  Future<Course> addCourse(Course course) async {
    if (course.isInBox) {
      course.save();
    } else {
      course.id = await courseBox.add(course);
    }
    debugPrint('course: $course');
    return course;
  }

  Future<Course> getCourse(String courseName) async {
    return courseBox.values.firstWhere((course) => course.name == courseName);
  }

  void getAllData() {
    debugPrint('-----------------------------------------------------');
    debugPrint('courses:  ${courseBox.values.toList()}');
    debugPrint('students:  ${studentBox.values.toList()}');
  }
}
