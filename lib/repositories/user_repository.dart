import 'package:app_users/models/task_model.dart';
import 'package:app_users/models/user_model.dart';

abstract class UsuarioRepository {
  Future carregarDB();
  Future<void> salvar(UserModel user);
  Future<void> alterar(UserModel user);
  Future<void> excluir(UserModel user);
  Future<void> salvarTarefa(TaskModel tarefa);
  Future<void> alterarTarefa(TaskModel tarefa);
  Future<void> excluirTarefa(TaskModel tarefa);
  Future<List<UserModel>> obterDados();
  Future<List<TaskModel>> obterDadosTarefa();
  Future<List<TaskModel>> obterQtdTarefasUsuario();
  Future<List<UserModel>> tarefaUsuario(String id);
}
