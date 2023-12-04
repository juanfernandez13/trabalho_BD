import 'package:app_users/models/task_model.dart';
import 'package:app_users/pages/data_task_user_page.dart';
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
  SqliteRepository sqliteUserRepository = SqliteRepositoryImpl();
  List<TaskModel> userTasksList = [];
  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  void loadTasks() async {
    userTasksList = await sqliteUserRepository.getUserTasks(widget.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("suas tarefas"),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: userTasksList.length,
                  itemBuilder: (_, index) {
                    TaskModel task = userTasksList[index];

                    return ListTile(
                      leading: Checkbox(
                          value: task.isCompleted,
                          onChanged: (value) async {
                            task.isCompleted = !task.isCompleted;
                            await sqliteUserRepository.updateTask(task);
                            setState(() {});
                          }),
                      title: TextFormField(
                        minLines: 1,
                        maxLines: 6,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        initialValue: task.description,
                        onChanged: (value) async {
                          setState(() {
                            task.description = value;
                          });
                          await sqliteUserRepository.updateTask(task);
                        },
                      ),
                      trailing: FittedBox(
                        fit: BoxFit.contain,
                        child: Row(
                          children: [
                            Icon(
                              Icons.task,
                              color:
                                  task.isCompleted ? Colors.green : Colors.red,
                            ),
                            IconButton(
                                onPressed: () async {
                                  await sqliteUserRepository.deleteTask(task);
                                  setState(() {
                                    
                                  });
                                },
                                icon: const Icon(Icons.delete))
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => DataTaskUserPage(
                        idUser: widget.id,
                      ))),
          child: const FittedBox(
              fit: BoxFit.contain,
              child: Row(
                children: [Icon(Icons.add), Text("Nova tarefa")],
              ))),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
