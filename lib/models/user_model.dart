class UserModel {
  String idUser = "";
  String name = "";
  String cpf = "";
  String email = "";

  UserModel(this.idUser, this.name, this.cpf, this.email);

  UserModel.fromJson(Map<String, dynamic> json) {
    idUser = json['idUser'];
    name = json['nome'];
    cpf = json['cpf'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idUser'] = this.idUser;
    data['nome'] = this.name;
    data['cpf'] = this.cpf;
    data['email'] = this.email;
    return data;
  }
}
