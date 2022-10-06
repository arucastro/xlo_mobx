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
    
    parseUser.set<String>(keyUserName, user.name!);
    parseUser.set<String>(keyUserPhone, user.phone!);
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

  Future<User> loginWithEmail(String email, String password) async {
    final parseUser = ParseUser(email, password, null);

    final response = await parseUser.login();

    if(response.success){
      return mapParseUser(response.result);
    }else{
      return Future.error(ParseErrors.getDescription(response.error!.code) as String);
    }
  }

  Future<User?> currentUser() async{
    final ParseUser? parseUser = await ParseUser.currentUser();

    if (parseUser != null){
      final response = await ParseUser.getCurrentUserFromServer(parseUser.sessionToken!);
      if(response!.success){
        return mapParseUser(response.result);
      }else{
        await parseUser.logout();
      }
    }else {
      return null;
    }
    return null;
  }


  Future<void> doUserLogout() async {
    final user = await ParseUser.currentUser();
    await user.logout();
  }

  Future<void> save(User user) async{
    final ParseUser? parseUser = await ParseUser.currentUser();

    if(parseUser != null){
      parseUser.set<String>(keyUserName, user.name!);
      parseUser.set<String>(keyUserPhone, user.phone!);
      parseUser.set<num>(keyUserType, user.type.index);

      if(user.pass != null){
        parseUser.password = user.pass;
      }

      final response = await parseUser.save();

      if(!response.success){
        return Future.error(ParseErrors.getDescription(response.error!.code) as String);
      }

      if(user.pass != null){
        await parseUser.logout();

        final loginResponse = await ParseUser(user.email, user.pass, '').login();

        if(!loginResponse.success){
          return Future.error(ParseErrors.getDescription(response.error!.code) as String);
        }
      }
    }
  }
}
