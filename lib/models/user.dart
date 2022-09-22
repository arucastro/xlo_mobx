enum UserType{ PARTICULAR, PROFESSIONAL}

class User{
  User({required this.name, required this.email, required this.phone, required this.pass, this.type = UserType.PARTICULAR});

  String name;
  String email;
  String phone;
  String pass;
  UserType type;



}