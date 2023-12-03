import 'package:app_users/models/task_model.dart';
import 'package:app_users/repositories/impl/sqlite_user_repository.dart';
import 'package:app_users/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class DataTaskUserPage extends StatefulWidget {
  final String? idUser;
  const DataTaskUserPage({super.key, this.idUser});

  @override
  State<DataTaskUserPage> createState() => _DataTaskUserPageState();
}

class _DataTaskUserPageState extends State<DataTaskUserPage> {
  TextEditingController descriptionController = TextEditingController();
  SqliteRepository repository = SqliteRepositoryImpl();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextField(
              controller: descriptionController,
            ),
            TextButton(
                onPressed: () async {
                  await repository.saveTask(TaskModel(
                      "", widget.idUser!, descriptionController.text, false));
                  Navigator.pop(context);
                },
                child: Text("Salvar tarefa"))
          ],
        ),
      ),
    );
  }
}
