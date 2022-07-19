import 'package:flutter/material.dart';
import 'package:todo_with_bloc_pattern/model/dialog_type.dart';

import '../model/task.dart';
import 'bloc/home_bloc.dart';
import 'bloc/home_provider.dart';
import 'new_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = HomeBloc();
    bloc.initValues();

    bloc.isAddCompletedStream.listen((event) {
      if (event) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo app'),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: () async {
          final result = await showDialog<String>(
              context: context,
              builder: (context) => Dialog(
                  child: HomeProvider(bloc,
                      child: const CreateNewTask(
                        dialogType: DialogType.add,
                      ))));
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => const CreateNewTask()));
        },
      ),
    );
  }

  Widget _body() {
    return StreamBuilder<List<Task>>(
        stream: bloc.taskStream,
        builder: (context, tasks) {
          if (!tasks.hasData) {
            return Container();
          } else {
            return ListView.builder(
                itemCount: tasks.requireData.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: (){
                      bloc.removeTask(tasks.requireData[index].id);
                    },
                    onTap: () async {
                      final result = await showDialog<String>(
                          context: context,
                          builder: (context) => Dialog(
                              child: HomeProvider(bloc,
                                  child: CreateNewTask(
                                    task: tasks.requireData[index],
                                    dialogType: DialogType.update,
                                  ))));
                    },
                    child: ListTile(
                      title: Text(tasks.requireData[index].title),
                      trailing: Checkbox(
                        value: tasks.requireData[index].isDone,
                        onChanged: (value) {
                          bloc.tasksValue[index].isDone = value ?? false;
                          bloc.doneTask(bloc.tasksValue[index]);
                          //check and uncheck task
                        },
                      ),
                    ),
                  );
                });
          }
        });
  }
}
