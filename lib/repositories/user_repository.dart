import 'package:app_users/models/task_model.dart';
import 'package:app_users/models/user_model.dart';

abstract class UsuarioRepository {
  Future loadDB();
  Future<void> saveUser(UserModel user);
  Future<void> updateUser(UserModel user);
  Future<void> deleteUser(UserModel user);
  Future<void> saveTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(TaskModel task);
  Future<List<UserModel>> getUsers();
  Future<List<TaskModel>> getTasks();
  Future<List<TaskModel>> getLengthUserTasks();
  Future<List<TaskModel>> getUsersWithTask();
  Future<List<UserModel>> getUserTasks(String id);
  Future<dynamic> getOlderUser();
  Future<dynamic> getNewestUser();
  Future<dynamic> getAvgAgeUser();
}
