import 'dart:ui';

import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {

  @observable
  String? email;

  @action
  void setEmail(String value) => email = value;
  @computed
  bool get emailValid => email != null && email!.isEmailValid();
  String? get emailError =>
      email == null || emailValid ? null : 'E-mail invãlido';

  @observable
  String? password;

  @action
  void setPassword(String value) => password = value;

  @computed
  bool get passValid => password != null && password!.length > 4;
  String? get passError =>
      password == null || passValid ? null : 'Senha invãlida';

  @computed get isFormValid => emailValid && passValid;

  @computed
  VoidCallback? get loginPressed => (isFormValid && !loading) ? _login : null;

  @observable
  bool loading = false;

  @observable
  String? error;

  Future<void> _login() async{
    loading = true;
    error = null;

    try {
      final user = await UserRepository().loginWithEmail(email!, password!);
      GetIt.I<UserManagerStore>().setUser(user);
    } catch(e){
      error = e.toString();
    }
    loading = false;
  }

}