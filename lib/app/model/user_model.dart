class UserModel {
  String? id;
  final String name;
  final String email;
  final String phone;
  final String password;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });
}