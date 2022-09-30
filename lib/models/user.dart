enum UserType { PARTICULAR, PROFESSIONAL }

class User {
  User(
      {this.id,
      required this.name,
      required this.email,
      required this.phone,
      this.pass,
      this.type = UserType.PARTICULAR,
      this.createdAt});

  String? id;
  String? name;
  String? email;
  String? phone;
  String? pass;
  UserType type;
  DateTime? createdAt;

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, phone: $phone, pass: $pass, type: $type, createdAt: $createdAt}';
  }
}
