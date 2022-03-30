import 'package:flutter/material.dart';
import 'package:flutter_application_test_hive/data/data.dart';
import 'package:flutter_application_test_hive/screen/home.dart';
import 'package:hive_flutter/adapters.dart';

const studentBoxName = 'students';
const courseBoxName = 'courses';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(StudentAdapter());
  Hive.registerAdapter(CourseAdapter());
  await Hive.openBox<Student>(studentBoxName);
  await Hive.openBox<Course>(courseBoxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hive',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}
