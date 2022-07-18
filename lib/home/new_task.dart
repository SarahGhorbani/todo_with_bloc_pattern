import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateNewTask extends StatefulWidget {
  const CreateNewTask({Key? key}) : super(key: key);

  @override
  _CreateNewTaskState createState() => _CreateNewTaskState();
}

class _CreateNewTaskState extends State<CreateNewTask> {
  late final _inputController;

  @override
  void initState() {
    super.initState();
    _inputController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('add new task'),
        ),
        body: Column(
          children: [
            Text('title'),
            TextField(
              controller: _inputController,
            ),
            ElevatedButton(onPressed: () {}, child: Text('add'))
          ],
        ));
  }
}
