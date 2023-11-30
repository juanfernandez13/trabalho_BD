class UserModel {
  String idUser = "";
  String nome = "";
  String cpf = "";
  String email = "";

  UserModel(this.idUser, this.nome, this.cpf, this.email);

  UserModel.fromJson(Map<String, dynamic> json) {
    idUser = json['idUser'];
    nome = json['nome'];
    cpf = json['cpf'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idUser'] = this.idUser;
    data['nome'] = this.nome;
    data['cpf'] = this.cpf;
    data['email'] = this.email;
    return data;
  }
}
