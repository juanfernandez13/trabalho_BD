class UserModel {
  String idUser = "";
  String name = "";
  int age = 0;
  String cpf = "";
  String email = "";

  UserModel(this.idUser, this.name, this.age, this.cpf, this.email);

  UserModel.fromJson(Map<String, dynamic> json) {
    idUser = json['idUser'].toString();
    name = json['name'];
    age = json['age'];
    cpf = json['cpf'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idUser'] = idUser;
    data['name'] = name;
    data['age'] = age;
    data['cpf'] = cpf;
    data['email'] = email;
    return data;
  }
}
