import 'package:app_users/models/task_model.dart';
import 'package:app_users/models/user_model.dart';

abstract class SqliteRepository {
  Future loadDB();
  Future<void> saveUser(UserModel user);
  Future<void> updateUser(UserModel user);
  Future<void> deleteUser(UserModel user);
  Future<void> saveTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(TaskModel task);
  Future<List<UserModel>> getUsers();
  Future<Map<String, double>> getCountTasksCompletedAndIncompleted();
  Future<UserModel> getUserById(String id);
  Future<List<TaskModel>> getTasks();
  Future<List<Map<String, int>>> getLengthUserTasks();
  Future<List<TaskModel>> getUsersWithTask();
  Future<List<TaskModel>> getUserTasks(String id);
  Future<String> getOlderUser();
  Future<String> getNewestUser();
  Future<String> getAvgAgeUser();
}
