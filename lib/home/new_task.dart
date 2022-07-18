import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bloc/home_bloc.dart';
import 'bloc/home_provider.dart';

class CreateNewTask extends StatefulWidget {
  const CreateNewTask({Key? key}) : super(key: key);

  @override
  _CreateNewTaskState createState() => _CreateNewTaskState();
}

class _CreateNewTaskState extends State<CreateNewTask> {
  late HomeBloc bloc;
  late var _titleController = TextEditingController();
  late var _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    bloc = HomeProvider.of(context);
    return Column(
      children: [
        TextFormField(
          onChanged: (value) {
            _titleController.text = value;
          },
          controller: _titleController,
          decoration: const InputDecoration(hintText: "title"),
        ),
        TextFormField(
          onChanged: (value) {
            _descController.text = value;
          },
          controller: _descController,
          decoration: const InputDecoration(hintText: "desc"),
        ),
        ElevatedButton(
            onPressed: () {
              // bloc.add
            },
            child: const Text('add'))
      ],
    );
  }
}
