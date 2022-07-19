import 'package:flutter/material.dart';
import 'package:todo_with_bloc_pattern/model/dialog_type.dart';
import 'package:todo_with_bloc_pattern/model/tag/tag.dart';
import 'package:todo_with_bloc_pattern/widgets/filter_list.dart';

import '../../model/task/task.dart';
import '../../widgets/new_task.dart';
import 'bloc/home_bloc.dart';
import 'bloc/home_provider.dart';

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
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<List<Task>>(
            stream: bloc.remainingTaskStream,
            builder: (context, remainingTasks) {
              if (!remainingTasks.hasData) {
                return const Text('ToDos');
              } else {
                String remainingCounter =
                    remainingTasks.requireData.length.toString();
                return Text('remaining ToDos: $remainingCounter');
              }
            }),
      ),
      body: _body(),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          child: const Icon(Icons.keyboard_return_rounded),
          onPressed: () {
            bloc.getTasks();
          },
        ),
        FloatingActionButton(
          child: const Icon(Icons.filter_alt_outlined),
          onPressed: () async {
            await showDialog<String>(
                context: context,
                builder: (context) => Dialog(
                    child: HomeProvider(bloc,
                        child: StreamBuilder<List<Tag>>(
                            stream: bloc.tagStream,
                            builder: (context, tags) {
                              if (!tags.hasData) {
                                return Container();
                              } else {
                                return HomeProvider(bloc,
                                    child: FilterListWidget(
                                        tags: tags.requireData));
                              }
                            }))));
          },
        ),
        FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            await showDialog<String>(
                context: context,
                builder: (context) => Dialog(
                    child: HomeProvider(bloc,
                        child: const CreateNewTask(
                          dialogType: DialogType.add,
                        ))));
          },
        ),
      ]),
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
                    onLongPress: () {
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
