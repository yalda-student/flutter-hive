import 'package:flutter/material.dart';
import 'package:flutter_application_test_hive/data/data.dart';
import 'package:flutter_application_test_hive/data/datasourrce.dart';
import 'package:flutter_application_test_hive/main.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dataSource =
        DataSource(Hive.box(studentBoxName), Hive.box(courseBoxName));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _AddStudent(dataSource: dataSource),
          const Divider(),
          _AddCourse(dataSource: dataSource),
          const Divider(),
          TextButton(
              onPressed: () {
                dataSource.getAllData();
              },
              child: const Text('Log all data')),
        ],
      ),
    );
  }
}

class _AddStudent extends StatelessWidget {
  final DataSource dataSource;
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _AddStudent({Key? key, required this.dataSource}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 120,
                child: TextFormField(
                  controller: _firstController,
                  decoration: const InputDecoration(
                    hintText: 'First Name',
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Fill box';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 15),
              SizedBox(
                width: 120,
                child: TextFormField(
                    controller: _lastController,
                    decoration: const InputDecoration(
                      hintText: 'Last Name',
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Fill box';
                      }
                      return null;
                    }),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 150,
            child: TextFormField(
              controller: _courseController,
              decoration: const InputDecoration(
                hintText: 'Course Name',
              ),
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Fill box';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
              onPressed: () async {
                final validate = _formKey.currentState!.validate();

                if (validate) {
                  String courseName = _courseController.text;
                  var course = await dataSource.getCourse(courseName);

                  var student = Student();
                  student.firstName = _firstController.text;
                  student.lastName = _lastController.text;
                  student.courses.add(course);
                  dataSource.addStudent(student);
                }
              },
              child: const Text('Add student'))
        ],
      ),
    );
  }
}

class _AddCourse extends StatelessWidget {
  final DataSource dataSource;
  final TextEditingController _courseController = TextEditingController();

  _AddCourse({Key? key, required this.dataSource}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 150,
          child: TextField(
            controller: _courseController,
            decoration: const InputDecoration(
              hintText: 'Course Name',
            ),
            textInputAction: TextInputAction.done,
          ),
        ),
        TextButton(
            onPressed: () async {
              final course = Course();
              String courseName = _courseController.text;
              course.name = courseName;
              dataSource.addCourse(course);
              
            },
            child: const Text('Add course'))
      ],
    );
  }
}
