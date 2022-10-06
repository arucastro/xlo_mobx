import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';

part 'user_manager_store.g.dart';

class UserManagerStore = _UserManagerStore with _$UserManagerStore;

abstract class _UserManagerStore with Store {

  _UserManagerStore(){
    _getCurrentUser();
  }

  @observable
  User? user;

  @action
  void setUser(User? value) => user = value;

  @computed
  bool get isUserLogged => user != null;

  Future<void> _getCurrentUser() async{
    final user = await UserRepository().currentUser();
    if (user != null){
      setUser(user);
    }
  }

  Future<void> logout() async{
    await UserRepository().doUserLogout();
    setUser(null);
  }
}