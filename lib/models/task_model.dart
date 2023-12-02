class TaskModel {
  String idTask = "";
  String idUser = "";
  String description = "";
  bool isCompleted = false;

  TaskModel(this.idTask, this.idUser, this.description, this.isCompleted);

  TaskModel.fromJson(Map<String, dynamic> json) {
    idTask = json['idTask'].toString();
    idUser = json['idUser'].toString();
    description = json['description'];
    isCompleted = json['isCompleted'] == 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTask'] = idTask;
    data['idUser'] = idUser;
    data['description'] = description;
    data['isCompleted'] = isCompleted;
    return data;
  }
}