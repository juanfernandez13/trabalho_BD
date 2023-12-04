import 'package:app_users/models/task_model.dart';
import 'package:app_users/models/user_model.dart';
import 'package:mobx/mobx.dart';

abstract class SqliteRepository with Store{
  Future loadDB();
  
  Future<List<UserModel>> getUsers();
  Future<void> saveUser(UserModel user);
  Future<void> updateUser(UserModel user);
  Future<void> deleteUser(UserModel user);
  Future<UserModel> getUserById(String id);
  Future<List<UserModel>> getUsersWithTask();

  Future<List<TaskModel>> getTasks();
  Future<void> saveTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(TaskModel task);
  Future<List<TaskModel>> getUserTasks(String id);
  Future<Map<String, double>> getCountTasksCompletedAndIncompleted();
  Future<List<Map<String, int>>> getLengthUserTasks();

  Future<String> getOlderUser();
  Future<String> getNewestUser();
  Future<String> getAvgAgeUser();
}
