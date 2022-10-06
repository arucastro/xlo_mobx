import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/components/error_box.dart';
import 'package:xlo_mobx/stores/login_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

import '../signup/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginStore loginStore = LoginStore();

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  void initState(){
    super.initState();

    when((_) => userManagerStore.user != null,() {
     Navigator.of(context).pop(true);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 50),
        child: SingleChildScrollView(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 16,
            margin: const EdgeInsets.symmetric(horizontal: 32),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Observer(builder: (_){
                    return ErrorBox(message: loginStore.error);
                  }),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Colors.blue[800],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Login com Facebook',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Text(
                    'ou \n Acessar com E-mail:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[900],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: Text(
                      'E-mail',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Observer(builder: (_) {
                    return TextField(
                      enabled: !loginStore.loading,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        isDense: true,
                        errorText: loginStore.emailError,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: loginStore.setEmail,
                    );
                  }),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Senha',
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'esqueci minha senha.',
                            style: TextStyle(
                                color: Colors.purple,
                                decoration: TextDecoration.underline,
                                fontSize: 15),
                          ),
                        )
                      ],
                    ),
                  ),
                  Observer(builder: (_) {
                    return TextField(
                      enabled: !loginStore.loading,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        errorText: loginStore.passError,
                      ),
                      obscureText: true,
                      onChanged: loginStore.setPassword,
                    );
                  }),
                  const SizedBox(height: 16),
                  Observer(builder: (_) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      height: 35,
                      child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                disabledBackgroundColor: Colors.orangeAccent,
                                backgroundColor: Colors.deepOrange,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                              ),
                              onPressed: loginStore.loginPressed,
                              child: loginStore.loading
                                  ? const CircularProgressIndicator(
                                valueColor:
                                AlwaysStoppedAnimation(Colors.white70),
                              )
                                  : const Text(
                                'Entrar',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                    );
                  }),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nâo possui uma conta?',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                        },
                        child: const Text(
                          'Cadastre-se',
                          style: TextStyle(
                              color: Colors.purple,
                              decoration: TextDecoration.underline,
                              fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
