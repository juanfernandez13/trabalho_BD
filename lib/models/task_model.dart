class TaskModel {
  String idTask = "";
  String idUser = "";
  String description = "";
  bool isCompleted = false;

  TaskModel(this.idTask, this.idUser, this.description, this.isCompleted);

  TaskModel.fromJson(Map<String, dynamic> json) {
    idTask = json['idTask'];
    idUser = json['idUser'];
    description = json['description'];
    isCompleted = json['isCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idTask'] = this.idTask;
    data['idUser'] = this.idUser;
    data['description'] = this.description;
    data['isCompleted'] = this.isCompleted;
    return data;
  }
}