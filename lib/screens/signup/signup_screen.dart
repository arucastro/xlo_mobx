import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/signup/components/field_title.dart';
import 'package:xlo_mobx/stores/signup_store.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final SignupStore signupStore = SignupStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
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
                  children:  [
                    FieldTitle(title: 'Apelido ', subtitle: 'Como aparecerá em seus anúncios',),
                    Observer(
                      builder: (_){
                        return TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Exemplo: João S',
                            isDense: true,
                            errorText: signupStore.nameError,
                          ),
                          onChanged: signupStore.setName,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    FieldTitle(title: 'E-mail ', subtitle: 'Enviaremos um e-mail de confirmação',),
                    Observer(builder: (_){
                      return TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'exemplo@email.com',
                          isDense: true,
                          errorText: signupStore.emailError
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        onChanged: signupStore.setEmail,
                      );
                    }),
                    const SizedBox(height: 16),
                    FieldTitle(title: 'Celular ', subtitle: 'Proteja sua Conta',),
                    Observer(builder: (_){
                      return TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '(99) 9 9999-9999',
                          isDense: true,
                          errorText: signupStore.phoneError,
                        ),
                        onChanged: signupStore.setPhone,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter(),
                        ],
                      );
                    }),
                    const SizedBox(height: 16),
                    FieldTitle(title: 'Senha ', subtitle: 'Use letras, números e caracteres especiais',),
                    Observer(builder: (_){
                      return TextField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          isDense: true,
                          errorText: signupStore.pass1Error,
                        ),
                        onChanged: signupStore.setPass1,
                        obscureText: true,
                      );
                    }),
                    const SizedBox(height: 16),
                    FieldTitle(title: 'Confirmar senha ', subtitle: 'Repita a senha',),
                    Observer(builder: (_){
                      return TextField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          isDense: true,
                          errorText: signupStore.pass2Error
                        ),
                        obscureText: true,
                        onChanged: signupStore.setPass2,
                      );
                    }),
                    const SizedBox(height: 16),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      height: 35,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          disabledBackgroundColor: Colors.orangeAccent,
                          backgroundColor: Colors.deepOrange,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Cadastrar',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Já possui umma conta?',
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: Navigator.of(context).pop,
                          child: const Text(
                            'Entrar',
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
      ),
    );
  }
}
