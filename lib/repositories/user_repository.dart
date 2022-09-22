import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';

import '../models/user.dart';

class UserRepository {
  Future<void> signUp(User user) async{
    final parseUser = ParseUser(
      user.email,
      user.pass,
      user.email,
    );
    
    parseUser.set<String>(keyUserName, user.name);
    parseUser.set<String>(keyUserPhone, user.phone);
    parseUser.set(keyUserType, user.type.index);

    await parseUser.signUp();
    
  }
}
