import 'package:app_users/models/task_model.dart';
import 'package:app_users/models/user_model.dart';
import 'package:app_users/repositories/impl/database.dart';
import 'package:app_users/repositories/user_repository.dart';

class SqliteUserRepository implements UsuarioRepository {
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
    print(result);
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
        'SELECT user.name, COUNT(task.idTask) FROM task INNER JOIN user GROUP BY user.idUser');
    print(result);
    return tarefaList;
  }

  @override
  Future<List<UserModel>> getUserTasks(String id) async {
    List<UserModel> userList = [];
    var db = await SqliteDatabase().getDatabase();
    var result = await db.rawQuery('''SELECT user.name, task.description
                                        FROM user 
                                        INNER JOIN task
                                        WHERE user.idUser = ?''', [id]);
    print(result);
    return userList;
  }

  @override
  Future<void> saveUser(UserModel user) async {
    var db = await SqliteDatabase().getDatabase();
    await db.rawInsert('INSERT INTO user (name, cpf, email) values(?,?,?)',
        [user.name, user.cpf, user.email]);
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
    await db.rawInsert('UPDATE task SET description = ?, isCompleted = ?', [
      task.description,
      task.isCompleted ? 1 : 0,
    ]);
  }

  @override
  Future<void> deleteTask(TaskModel task) async {
    var db = await SqliteDatabase().getDatabase();
    await db.rawInsert('DELETE FROM task idTask = ?', [task.idTask]);
  }

  @override
  Future<void> updateUser(UserModel user) async {
    var db = await SqliteDatabase().getDatabase();
    await db.rawInsert('UPDATE user SET name = ?, cpf = ?, email = ?',
        [user.name, user.cpf, user.email]);
  }

  @override
  Future<void> deleteUser(UserModel user) async {
    var db = await SqliteDatabase().getDatabase();
    await db.rawInsert('DELETE FROM user idUser = ?', [user.idUser]);
  }
}
