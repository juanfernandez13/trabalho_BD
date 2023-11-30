import 'package:app_users/models/task_model.dart';
import 'package:app_users/models/user_model.dart';
import 'package:app_users/repositories/impl/database.dart';
import 'package:app_users/repositories/impl/sqlite_user_repository.dart';
import 'package:app_users/repositories/user_repository.dart';
import 'package:flutter/material.dart';

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
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: TextButton(
                  child: const Text("fgfdf"),
                  onPressed: () async {
                    await userRepository.carregarDB();
                    await userRepository.salvar(
                        UserModel("1","juan", '46545646544', "juan@juan.com"));
                    await userRepository.obterDados();
                    await userRepository.obterDadosTarefa();
                    await userRepository.obterQtdTarefasUsuario();
                    await userRepository.tarefaUsuario("4");
                  }),
            )
          ],
        ),
      ),
    );
  }
}
