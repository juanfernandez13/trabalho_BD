import 'package:app_users/repositories/impl/sqlite_user_repository.dart';
import 'package:app_users/repositories/user_repository.dart';
import 'package:flutter/material.dart';

import '../models/task_model.dart';
import '../models/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UsuarioRepository userRepository = SqliteUserRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TextButton(
                child: const Text("fgfdf"),
                onPressed: () async {
                  //await userRepository.saveUser(UserModel("", "joao2", 20, "78978978944", "joao@gmail.com"));
                  //await userRepository.saveUser(UserModel("", "juan", 30,"78978978944", "juan@gmail.com"));
                  //await userRepository.saveTask(TaskModel("", "1", "primeira descrição", false));
                  //await userRepository.saveTask(TaskModel("", "1", "segunda descrição", false));
                  //await userRepository.saveTask(TaskModel("", "2", "terceira descrição", false));
                  //await userRepository.getUsers();
                  //await userRepository.getTasks();
                  //await userRepository.getLengthUserTasks();
                  //await userRepository.getUserTasks("1");
                  //await userRepository.getUsersWithTask();
                  //await userRepository.getOlderUser();
                  //await userRepository.getNewestUser();
                  await userRepository.getAvgAgeUser();
                }),
          )
        ],
      ),
    );
  }
}
