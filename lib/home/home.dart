import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_with_bloc_pattern/home/new_task.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo jhgkjfdhg'),
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreateNewTask()));
        },
      ),
    );
  }

  Widget _body() {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('data'),
            trailing: Checkbox(
              value: true,
              onChanged: (value) {
                //check and uncheck task
              },
            ),
          );
        });
  }
}
