import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/repositories/parse_errors.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';

import '../models/user.dart';

class UserRepository {
  Future<User> signUp(User user) async{
    final parseUser = ParseUser(
      user.email,
      user.pass,
      user.email,
    );
    
    parseUser.set<String>(keyUserName, user.name);
    parseUser.set<String>(keyUserPhone, user.phone);
    parseUser.set(keyUserType, user.type.index);

    final response = await parseUser.signUp();

    if(response.success){
      return mapParseUser(response.result);
    }else {
      return Future.error(ParseErrors.getDescription(response.error!.code) as String);
    }

  }

  User mapParseUser(ParseUser parseUser){
    return User(
      id: parseUser.objectId!,
      name: parseUser.get(keyUserName),
      email: parseUser.get(keyUserEmail),
      phone: parseUser.get(keyUserPhone),
      type: UserType.values[parseUser.get(keyUserType)],
      createdAt: parseUser.get(keyUserCreatedAt),
    );
  }


}
