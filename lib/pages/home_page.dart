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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TextButton(
                child: const Text("fgfdf"),
                onPressed: () async {
                  //await userRepository.salvar(UserModel("", "marcelo", "78978978944", "marcelo@gmail.com"));
                  //await userRepository.salvarTarefa(TaskModel("", "1", "segunda descrição", false));
                  //await userRepository.salvarTarefa(TaskModel("", "2", "terceira descrição", false));
                  await userRepository.obterDados();
                  await userRepository.obterDadosTarefa();
                  await userRepository.obterQtdTarefasUsuario();
                  await userRepository.tarefaUsuario("1");
                }),
          )
        ],
      ),
    );
  }
}
