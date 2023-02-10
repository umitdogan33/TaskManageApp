class UserModel {
  late String email;
  late String password;
  late String firstName;
  late String lastName;
  UserModel({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  factory UserModel.fromJson(Map<dynamic,dynamic> json){
    return UserModel(
      email: json['email'],
      password: json['password'],
      firstName: json['firstname'],
      lastName: json['lastname'],
    );
  }
}
