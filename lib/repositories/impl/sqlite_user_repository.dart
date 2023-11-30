import 'package:app_users/models/task_model.dart';
import 'package:app_users/models/user_model.dart';
import 'package:app_users/repositories/impl/database.dart';
import 'package:app_users/repositories/user_repository.dart';

class SqliteUserRepository implements UsuarioRepository {
  SqliteUserRepository();
  SqliteUserRepository._criar();

  @override
  Future carregarDB() async {
    return SqliteUserRepository._criar();
  }

  @override
  Future<List<UserModel>> obterDados() async {
    List<UserModel> userList = [];
    var db = await SqliteDatabase().obterDatabase();
    var result = await db.rawQuery('SELECT * FROM usuario');
    print(result);
    return userList;
  }

  Future<List<TaskModel>> obterDadosTarefa() async {
    List<TaskModel> userList = [];
    var db = await SqliteDatabase().obterDatabase();
    var result = await db.rawQuery('SELECT * FROM tarefa');
    print(result);
    return userList;
  }

  @override
  Future<List<TaskModel>> obterQtdTarefasUsuario() async {
    List<TaskModel> tarefaList = [];
    var db = await SqliteDatabase().obterDatabase();
    var result = await db.rawQuery(
        'SELECT usuario.nome, COUNT(tarefa.idTarefa) FROM tarefa INNER JOIN usuario GROUP BY usuario.idUsuario');
    print(result);
    return tarefaList;
  }

  @override
  Future<List<UserModel>> tarefaUsuario(String id) async {
    List<UserModel> userList = [];
    var db = await SqliteDatabase().obterDatabase();
    var result = await db.rawQuery('''SELECT usuario.nome, tarefa.descricao
                                        FROM usuario 
                                        INNER JOIN tarefa
                                        WHERE usuario.idUsuario = ?''', [id]);
    print(result);
    return userList;
  }

  @override
  Future<void> salvar(UserModel user) async {
    var db = await SqliteDatabase().obterDatabase();
    await db.rawInsert('INSERT INTO usuario (nome, cpf, email) values(?,?,?)',
        [user.nome, user.cpf, user.email]);
  }

  @override
  Future<void> salvarTarefa(TaskModel task) async {
    var db = await SqliteDatabase().obterDatabase();
    await db.rawInsert(
        'INSERT INTO tarefa (descricao, concluida, idUsuario) values(?,?,?)',
        [task.description, task.isCompleted ? 1 : 0, task.idUser]);
  }

  @override
  Future<void> alterarTarefa(TaskModel task) async {
    var db = await SqliteDatabase().obterDatabase();
    await db.rawInsert('UPDATE tarefa SET descricao = ?, concluido = ?', [
      task.description,
      task.isCompleted ? 1 : 0,
    ]);
  }

  @override
  Future<void> excluirTarefa(TaskModel task) async {
    var db = await SqliteDatabase().obterDatabase();
    await db.rawInsert('DELETE FROM tarefa idTarefa = ?', [task.idTask]);
  }

  @override
  Future<void> alterar(UserModel user) async {
    var db = await SqliteDatabase().obterDatabase();
    await db.rawInsert('UPDATE usuario SET nome = ?, cpf = ?, email = ?',
        [user.nome, user.cpf, user.email]);
  }

  @override
  Future<void> excluir(UserModel user) async {
    var db = await SqliteDatabase().obterDatabase();
    await db.rawInsert('DELETE FROM usuario idUsuario = ?', [user.idUser]);
  }
}
