import 'package:app_users/pages/data_user_page.dart';
import 'package:app_users/pages/user_tasks_page.dart';
import 'package:app_users/repositories/impl/sqlite_user_repository.dart';
import 'package:app_users/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  SqliteRepository userRepository = SqliteRepositoryImpl();
  List<UserModel> listUsers = [];
  bool switchValue = false;
  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  void loadUsers() async {
    listUsers = await userRepository.getUsers();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text('Lista de usuários'),
              backgroundColor: Colors.blue,
            ),
            body: Column(
              children: [
                Row(
                  children: [
                    const Text("Apenas usuários com tarefas"),
                    Switch(
                        value: switchValue,
                        onChanged: (value) async {
                          switchValue = value;
                          listUsers = switchValue? await userRepository.getUsersWithTask() :await userRepository.getUsers(); 
                          setState(() {
                            
                          });
                        }),
                  ],
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: listUsers.length,
                        itemBuilder: (context, index) {
                          UserModel user = listUsers[index];
                          return ListTile(
                            title: Text(user.name),
                            subtitle: Text(
                              user.email,
                            ),
                            leading: const Icon(Icons.person_2_rounded),
                            trailing: FittedBox(
                              fit: BoxFit.contain,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => DataUserPage(
                                                    userModel: user,
                                                  ))),
                                      icon: const Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () async =>
                                          await userRepository.deleteUser(user),
                                      icon: const Icon(Icons.delete)),
                                ],
                              ),
                            ),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        UserTasksPage(id: user.idUser))),
                          );
                        }))
              ],
            ),
            floatingActionButton: ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DataUserPage(),
                ),
              ),
              child: const FittedBox(
                  fit: BoxFit.contain,
                  child: Row(
                    children: [Icon(Icons.add), Text("Novo usuário")],
                  )),
            )));
  }
}
