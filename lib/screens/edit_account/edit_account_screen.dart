import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:xlo_mobx/stores/edit_account_store.dart';

class EditAccountScreen extends StatelessWidget {
  EditAccountScreen({Key? key}) : super(key: key);

  final EditAccountStore store = EditAccountStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            margin: const EdgeInsets.all(28),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Observer(builder: (_){
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LayoutBuilder(builder: (_, constraints) {
                      return ToggleSwitch(
                        minWidth: constraints.biggest.width / 2.01,
                        labels: const ['Particular', 'Profissional'],
                        cornerRadius: 20,
                        inactiveBgColor: Colors.grey,
                        initialLabelIndex: 0,
                        onToggle: store.setUserType,
                      );
                    }),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        isDense: true,
                        labelText: 'Nome *',
                        errorText: store.nameError,
                      ),
                      onChanged: store.setName,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        isDense: true,
                        labelText: 'Telefone *',
                        errorText: store.phoneError,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        TelefoneInputFormatter(),
                      ],
                      onChanged: store.setPhone,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        labelText: 'Nova senha',),
                      onChanged: store.setPass1,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        isDense: true,
                        labelText: 'Confirmar nova senha',
                        errorText: store.passError,
                      ),
                      onChanged: store.setPass2,
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            disabledBackgroundColor: Colors.orangeAccent,
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25))),
                        onPressed: store.isFormValid ? () {} : null,
                        child: const Text(
                          'Salvar',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25))),
                        onPressed: (){},
                        child: const Text(
                          'Sair',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
