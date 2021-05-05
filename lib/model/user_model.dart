class UserModel {
  String id;
  String unique_id;
  String username;
  String password;
  String nameSurname;
  String email;
  String phone;
  String status;

  UserModel(
      {this.id,
      this.unique_id,
      this.username,
      this.password,
      this.nameSurname,
      this.email,
      this.phone,
      this.status});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unique_id = json['unique_id'];
    username = json['username'];
    password = json['password'];
    nameSurname = json['name_Surname'];
    email = json['email'];
    phone = json['phone'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unique_id'] = this.unique_id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['name_Surname'] = this.nameSurname;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['status'] = this.status;
    return data;
  }
}
