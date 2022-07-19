import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_with_bloc_pattern/model/dialog_type.dart';
import 'package:todo_with_bloc_pattern/model/task.dart';

import 'bloc/home_bloc.dart';
import 'bloc/home_provider.dart';

class CreateNewTask extends StatefulWidget {
  const CreateNewTask({Key? key, this.task, required this.dialogType})
      : super(key: key);
  final Task? task;
  final DialogType dialogType;
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
    initControllers();
  }

  void initControllers() {
    _titleController.text = widget.task?.title ?? "";
    _descController.text = widget.task?.description ?? "";
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
            widget.task?.title = value;
          },
          controller: _titleController,
          decoration: const InputDecoration(hintText: "title"),
        ),
        TextFormField(
          onChanged: (value) {
            _descController.text = value;
            widget.task?.description = value;
          },
          controller: _descController,
          decoration: const InputDecoration(hintText: "desc"),
        ),
        ElevatedButton(
            onPressed: () {
              onPressedButton(widget.dialogType);
            },
            child: Text(chooseTextButton(widget.dialogType)))
      ],
    );
  }

  void onPressedButton(DialogType type) {
    switch (type) {
      case DialogType.add:
        bloc.addTask(_titleController.text, _descController.text);
        break;
      case DialogType.update:
        bloc.updateTask(widget.task!);
        break;
    }
  }

  String chooseTextButton(DialogType type) {
    String text;
    switch (type) {
      case DialogType.add:
        text = 'add';
        break;
      case DialogType.update:
        text = 'update';
        break;
    }
    return text;
  }
}
