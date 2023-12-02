import 'package:app_users/models/task_model.dart';
import 'package:app_users/models/user_model.dart';
import 'package:app_users/repositories/impl/database.dart';
import 'package:app_users/repositories/user_repository.dart';

class SqliteUserRepository implements SqliteRepository {
  SqliteUserRepository();
  SqliteUserRepository._criar();

  @override
  Future loadDB() async {
    return SqliteUserRepository._criar();
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
  Future<List<TaskModel>> getTasks() async {
    List<TaskModel> userList = [];
    var db = await SqliteDatabase().getDatabase();
    var result = await db.rawQuery('SELECT * FROM task');
    print(result);
    return userList;
  }

  @override
  Future<List<TaskModel>> getLengthUserTasks() async {
    List<TaskModel> tarefaList = [];
    var db = await SqliteDatabase().getDatabase();
    var result = await db.rawQuery(
        'SELECT user.name, COUNT(task.idTask) FROM user INNER JOIN task ON user.idUser = task.idUser GROUP BY user.idUser');
    print(result);
    return tarefaList;
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
    //print(result);
    for (var e in result) {
      userTasksList.add(TaskModel.fromJson(e));
    }
    //print(userTasksList);
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
    await db.rawUpdate('UPDATE task SET description = ?, isCompleted = ?', [
      task.description,
      task.isCompleted ? 1 : 0,
    ]);
  }

  @override
  Future<void> deleteTask(TaskModel task) async {
    var db = await SqliteDatabase().getDatabase();
    await db.rawDelete('DELETE FROM task idTask = ?', [task.idTask]);
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
    await db.rawDelete('DELETE FROM user idUser = ?', [user.idUser]);
  }

  @override
  Future<List<TaskModel>> getUsersWithTask() async {
    var db = await SqliteDatabase().getDatabase();
    var result = await db.rawQuery(
        "SELECT DISTINCT user.idUser, user.name FROM user INNER JOIN task ON user.idUser = task.idUser");
    print(result);
    return [];
  }

  @override
  Future<int> getOlderUser() async {
    var db = await SqliteDatabase().getDatabase();
    var result =
        await db.rawQuery('SELECT user.name , MAX(user.age) FROM user');
    print(result);
    return 0;
  }

  @override
  Future<int> getNewestUser() async {
    var db = await SqliteDatabase().getDatabase();
    var result =
        await db.rawQuery('SELECT user.name , MIN(user.age) FROM user');
    print(result);
    return 0;
  }

  @override
  Future<int> getAvgAgeUser() async {
    var db = await SqliteDatabase().getDatabase();
    var result = await db.rawQuery('SELECT AVG(user.age) FROM user');
    print(result);
    return 0;
  }
}
