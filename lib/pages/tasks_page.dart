import 'package:app_users/models/task_model.dart';
import 'package:app_users/repositories/impl/sqlite_user_repository.dart';
import 'package:app_users/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class UserTasksPage extends StatefulWidget {
  final String id;
  const UserTasksPage({super.key, required this.id});

  @override
  State<UserTasksPage> createState() => _UserTasksPageState();
}

class _UserTasksPageState extends State<UserTasksPage> {
  SqliteRepository sqliteUserRepository = SqliteUserRepository();
  List<TaskModel> userTasksList = [];
  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  void loadTasks() async {
    userTasksList = await sqliteUserRepository.getUserTasks(widget.id);
    print(userTasksList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("suas tarefas"),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: userTasksList.length,
                  itemBuilder: (_, index) {
                    TaskModel task = userTasksList[index];
                    return ListTile(
                      leading: Icon(
                        Icons.task,
                        color: task.isCompleted ? Colors.green : Colors.red,
                      ),
                      title: Text(task.description),
                      subtitle: Text(task.idUser),
                    );
                  }))
        ],
      ),
    );
  }
}
