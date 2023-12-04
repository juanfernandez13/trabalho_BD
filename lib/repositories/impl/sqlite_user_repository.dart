import 'package:app_users/models/task_model.dart';
import 'package:app_users/models/user_model.dart';
import 'package:app_users/repositories/impl/database.dart';
import 'package:app_users/repositories/user_repository.dart';

class SqliteRepositoryImpl implements SqliteRepository {
  SqliteRepositoryImpl();
  SqliteRepositoryImpl._criar();

  @override
  Future loadDB() async {
    return SqliteRepositoryImpl._criar();
  }

  @override
  Future<List<UserModel>> getUsers() async {
    List<UserModel> userList = [];
    var db = await SqliteDatabase().getDatabase();
    var result = await db.rawQuery('SELECT * FROM user');
    for (var e in result) {
      userList.add(UserModel(
          e["idUser"].toString(),
          e["name"].toString(),
          int.tryParse(e["age"].toString()) ?? 0,
          e["cpf"].toString(),
          e["email"].toString()));
    }
    return userList;
  }

  @override
  Future<UserModel> getUserById(String id) async {
    late UserModel user;
    var db = await SqliteDatabase().getDatabase();
    var result = await db.rawQuery('SELECT * FROM user WHERE userId = ?', [id]);
    for (var e in result) {
      user = UserModel.fromJson(e);
    }
    return user;
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    List<TaskModel> taskList = [];
    var db = await SqliteDatabase().getDatabase();
    var result = await db.rawQuery('SELECT * FROM task');
    for (var element in result) {
      taskList.add(TaskModel.fromJson(element));
    }
    return taskList;
  }

  @override
  Future<List<Map<String, int>>> getLengthUserTasks() async {
    List<Map<String, int>> tarefaList = [];
    var db = await SqliteDatabase().getDatabase();
    var result = await db.rawQuery('''SELECT user.name, COUNT(task.idTask) 
                              FROM user 
                              INNER JOIN task ON user.idUser = task.idUser
                              GROUP BY user.idUser''');
    for (var element in result) {
      tarefaList.add({
        element['name'].toString():
            int.tryParse(element['COUNT(task.idTask)'].toString()) ?? 0
      });
    }
    return tarefaList;
  }

  @override
  Future<Map<String, double>> getCountTasksCompletedAndIncompleted() async {
    Map<String, double> chartMap = {};
    List<TaskModel> userTasksList = [];
    var db = await SqliteDatabase().getDatabase();
    var result = await db.rawQuery(
        '''SELECT COUNT(*) AS completo FROM task GROUP BY task.isCompleted''');
    chartMap["Completo"] = 0;
    chartMap["Incompleto"] = 0;
    if (result.isNotEmpty) {
      chartMap["Incompleto"] =
          double.tryParse(result.first.values.single.toString()) ?? 0;
    }
    if (result.length == 2) {
      chartMap["Completo"] =
          double.tryParse(result.last.values.single.toString()) ?? 0;
    }
    print(result);
    print(chartMap);
    return chartMap;
  }

  @override
  Future<List<TaskModel>> getUserTasks(String id) async {
    List<TaskModel> userTasksList = [];
    var db = await SqliteDatabase().getDatabase();
    var result = await db.rawQuery(
        '''SELECT task.idTask, task.idUser, task.isCompleted, task.description
                                        FROM user 
                                        INNER JOIN task ON user.idUser = task.idUser
                                        WHERE user.idUser = ?''', [id]);
    for (var e in result) {
      userTasksList.add(TaskModel.fromJson(e));
    }
    return userTasksList;
  }

  @override
  Future<void> saveUser(UserModel user) async {
    var db = await SqliteDatabase().getDatabase();
    await db.rawInsert(
        'INSERT INTO user (name, age,cpf, email) values(?,?,?,?)',
        [user.name, user.age, user.cpf, user.email]);
  }

  @override
  Future<void> saveTask(TaskModel task) async {
    var db = await SqliteDatabase().getDatabase();
    await db.rawInsert(
        'INSERT INTO task (description, isCompleted, idUser) values(?,?,?)',
        [task.description, task.isCompleted ? 1 : 0, task.idUser]);
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    var db = await SqliteDatabase().getDatabase();
    await db.rawUpdate('UPDATE task SET description = ?, isCompleted = ? WHERE task.idTask = ?', [
      task.description,
      task.isCompleted ? 1 : 0,
      task.idTask
    ]);
  }

  @override
  Future<void> deleteTask(TaskModel task) async {
    var db = await SqliteDatabase().getDatabase();
    await db.rawDelete('DELETE FROM task WHERE idTask = ?', [task.idTask]);
  }

  @override
  Future<void> updateUser(UserModel user) async {
    var db = await SqliteDatabase().getDatabase();
    await db.rawUpdate('UPDATE user SET name = ?, cpf = ?, email = ?',
        [user.name, user.cpf, user.email]);
  }

  @override
  Future<void> deleteUser(UserModel user) async {
    var db = await SqliteDatabase().getDatabase();
    await db.rawDelete('DELETE FROM user WHERE idUser = ?', [user.idUser]);
    await db.rawDelete('DELETE FROM task WHERE idUser = ?', [user.idUser]);
  }

  @override
  Future<List<UserModel>> getUsersWithTask() async {
    List<UserModel> listUsersWithTask = [];
    var db = await SqliteDatabase().getDatabase();
    var result = await db.rawQuery(
        "SELECT DISTINCT * FROM user INNER JOIN task ON user.idUser = task.idUser GROUP BY user.name");
    for (var element in result) {
      listUsersWithTask.add(UserModel.fromJson(element));
    }
    return listUsersWithTask;
  }

  @override
  Future<String> getOlderUser() async {
    var db = await SqliteDatabase().getDatabase();
    var result =
        await db.rawQuery('SELECT user.name , MAX(user.age) FROM user');
    return result[0]['MAX(user.age)'].toString();
  }

  @override
  Future<String> getAvgAgeUser() async {
    String avg = "";
    var db = await SqliteDatabase().getDatabase();
    var result = await db.rawQuery('SELECT AVG(user.age) FROM user');
    avg = result[0]['AVG(user.age)'].toString();
    return avg;
  }

  @override
  Future<String> getNewestUser() async {
    var db = await SqliteDatabase().getDatabase();
    var result =
        await db.rawQuery('SELECT user.name , MIN(user.age) FROM user');
    return result[0]['MIN(user.age)'].toString();
  }
}
