import 'package:app_users/models/task_model.dart';
import 'package:app_users/models/user_model.dart';
import 'package:app_users/repositories/impl/sqlite_user_repository.dart';
import 'package:app_users/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  SqliteRepository repository = SqliteRepositoryImpl();
  List<TaskModel> taskList = [];
  List<UserModel> userList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    taskList = await repository.getTasks();
    userList = await repository.getUsers();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todas as tarefas"),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: taskList.length,
                  itemBuilder: (_, index) {
                    TaskModel task = taskList[index];
                    UserModel user = userList.firstWhere((element) => element.idUser == task.idUser);
                    return ListTile(
                      leading: Icon(Icons.task,
                          color: task.isCompleted ? Colors.green : Colors.red),
                      title: Text(task.description),
                      subtitle: Text(user.name),
                    );
                  }))
        ],
      ),
      //floatingActionButton: FloatingActionButton(onPressed: () {}),
    );
  }
}
