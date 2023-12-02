import 'package:app_users/models/user_model.dart';
import 'package:app_users/repositories/impl/sqlite_user_repository.dart';
import 'package:app_users/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class DataUserPage extends StatefulWidget {
  final UserModel? userModel;
  const DataUserPage({super.key, this.userModel});

  @override
  State<DataUserPage> createState() => _DataUserPageState();
}

class _DataUserPageState extends State<DataUserPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController cpfController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.userModel != null) {
      UserModel user = widget.userModel!;
      nameController.text = user.name;
      ageController.text = user.age.toString();
      cpfController.text = user.cpf;
      emailController.text = user.email;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextField(
              controller: nameController,
            ),
            TextField(
              controller: ageController,
            ),
            TextField(
              controller: cpfController,
            ),
            TextField(
              controller: emailController,
            ),
            TextButton(
                onPressed: () async {
                  SqliteRepository repository = SqliteRepositoryImpl();
                  widget.userModel == null
                      ? await repository.saveUser(UserModel(
                          "",
                          nameController.text,
                          int.tryParse(ageController.text) ?? 0,
                          cpfController.text,
                          emailController.text))
                      : repository.updateUser(UserModel(
                          widget.userModel!.idUser,
                          nameController.text,
                          int.tryParse(ageController.text) ?? 0,
                          cpfController.text,
                          emailController.text));
                  Navigator.pop(context);
                },
                child: Text(
                    "${widget.userModel == null ? "Salvar" : "Editar"} usuário"))
          ],
        ),
      ),
    );
  }
}
