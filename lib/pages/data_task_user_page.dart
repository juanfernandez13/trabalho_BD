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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar tarefa"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              minLines: 6,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: "Digite a descrição"
                
              ),
              controller: descriptionController,
            ),
            TextButton(
                onPressed: () async {
                  await repository.saveTask(TaskModel(
                      "", widget.idUser!, descriptionController.text, false));
                  if(context.mounted) Navigator.pop(context);
                },
                child: const Text("Salvar tarefa"))
          ],
        ),
      ),
    );
  }
}
