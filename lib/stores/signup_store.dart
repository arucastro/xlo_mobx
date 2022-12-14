import 'dart:ui';

import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

part 'signup_store.g.dart';

class SignupStore = _SignupStore with _$SignupStore;

abstract class _SignupStore with Store {
  @observable
  String? name;

  @action
  void setName(String value) => name = value;

  @computed
  bool get nameValid => name != null && name!.length > 4;

  String? get nameError {
    if (name == null || nameValid) {
      return null;
    } else if (name != null && name!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'apelido curto demais';
    }
  }

  @observable
  String? email;

  @action
  void setEmail(String value) => email = value;

  @computed
  bool get emailValid => email != null && email!.isEmailValid();
  String? get emailError {
    if (email == null || emailValid) {
      return null;
    } else if (email != null || email!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'E-mail invãlido';
    }
  }

  @observable
  String? phone;

  @action
  void setPhone(String value) => phone = value;

  @computed
  bool get phoneValid => phone != null && phone!.length >= 14;
  String? get phoneError {
    if (phone == null || phoneValid) {
      return null;
    } else if (phone != null && phone!.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return 'Celular inválido';
    }
  }

  @observable
  String? pass1;

  @action
  void setPass1(String value) => pass1 = value;

  @computed
  bool get pass1Valid => pass1 != null && pass1!.length > 6;
  String? get pass1Error {
    if(pass1 == null || pass1Valid){
      return null;
    }else if (pass1 != null && pass1!.isEmpty){
      return 'Campo obrigatório';
    }else{
      return 'Senha muito curta';
    }
  }

  @observable
  String? pass2;

  @action
  void setPass2(String value) => pass2 = value;

  @computed
  bool get pass2Valid => pass2 != null && pass2! == pass1!;
  String? get pass2Error {
    if(pass2 == null || pass2Valid){
      return null;
    }else{
      return 'Senha não confere';
    }
  }

  @computed
  bool get isFormValid => nameValid && emailValid && phoneValid && pass1Valid && pass2Valid;

  @computed
  VoidCallback? get signUpPressed => (isFormValid && loading == false) ? _signUp : null;

  @observable
  bool loading = false;

  @observable
  String? error;

  Future<void> _signUp() async{
    loading = true;

    User user = User(
      name: name!,
      email: email!,
      phone: phone!,
      pass: pass1!,
    );

    try {
      final resultUser = await UserRepository().signUp(user);
      GetIt.I<UserManagerStore>().setUser(resultUser);
    }catch(e){
      error = e.toString();
    }

    loading = false;
  }

}
