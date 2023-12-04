import 'package:app_users/models/task_model.dart';
import 'package:app_users/models/user_model.dart';
import 'package:app_users/repositories/impl/sqlite_user_repository.dart';
import 'package:app_users/repositories/user_repository.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  final SqliteRepository repository = SqliteRepositoryImpl();

  @observable
  List<UserModel> usersList = [];

  @observable
  List<TaskModel> tasksList = [];

  @observable
  var olderUser = "";

  @observable
  var avgUser = "";

  @observable
  var newestUser = Observable("");

  @action
  getUsers() async {
    usersList = await repository.getUsers();
  }

  @action
  insertUsers(UserModel user) async {
    await repository.saveUser(user);
    usersList.add(user);
  }

  @action
  updateUsers(UserModel user) async {
    usersList.where((element) {
      if (element.idUser == user.idUser) {
        element = user;
      }
      return true;
    });
    await repository.updateUser(user);
  }

  @action
  deleteUsers(UserModel user) async {
    usersList.removeWhere((element) => element.idUser == user.idUser);
    await repository.deleteUser(user);
  }

  @action
  getTasks() async {
    tasksList = await repository.getTasks();
  }

  @action
  insertTasks(TaskModel task) async {
    tasksList.add(task);
    await repository.saveTask(task);
  }

  @action
  updateTasks(TaskModel task) async {
    tasksList.where((element) {
      if (element.idTask == task.idTask) {
        element = task;
      }
      return true;
    });
    await repository.updateTask(task);
  }

  @action
  deleteTasks(TaskModel task) async {
    tasksList.removeWhere((element) => element.idTask == task.idTask);
    await repository.deleteTask(task);
  }

  @action
  getOlderUser() async {
    olderUser = await repository.getOlderUser();
  }

  @action
  getAvgUser() async {
    avgUser = await repository.getAvgAgeUser();
  }

  @action
  getNewestUser() async {
    var value = await repository.getNewestUser();
    newestUser.value = value;
  }
}
