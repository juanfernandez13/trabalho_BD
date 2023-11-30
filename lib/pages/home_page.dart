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
  List<UserModel> listUsers = [];

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  void loadUsers() async {
    listUsers = await userRepository.getUsers();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('Lista de usuários')),
            backgroundColor: Colors.blue,
          ),
          body: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      itemCount: listUsers.length,
                      itemBuilder: (context, index) {
                        UserModel user = listUsers[index];
                        print(listUsers);
                        return ListTile(
                          title: Text(user.name),
                          subtitle: Text(
                            user.email,
                          ),
                          leading: const Icon(Icons.person_2_rounded),
                        );
                      }))
            ],
          )),
    );
  }
}
