import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/components/error_box.dart';
import 'package:xlo_mobx/screens/create/components/cep_field.dart';
import 'package:xlo_mobx/stores/create_store.dart';

import 'components/category_field.dart';
import 'components/hide_phone_field.dart';
import 'components/images_field.dart';

class CreateScreen extends StatelessWidget {
  CreateScreen({Key? key}) : super(key: key);

  final CreateStore createStore = CreateStore();

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(
      fontWeight: FontWeight.w500,
      color: Colors.grey,
      fontSize: 18,
    );

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: const Text('Criar Anúncio'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 16,
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: Observer(builder: (_) {
              if (createStore.loading) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                         Text(
                          'Salvando anúncio',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.purple,
                          ),
                           textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16,),
                           CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.purple),
                        ),
                      ],
                  ),
                );
              } else {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ImagesField(createStore: createStore),
                    TextFormField(
                      onChanged: createStore.setTitle,
                      decoration: InputDecoration(
                        errorText: createStore.titleError,
                        labelText: 'Título *',
                        labelStyle: labelStyle,
                        contentPadding:
                            const EdgeInsets.fromLTRB(16, 10, 12, 10),
                      ),
                    ),
                    TextFormField(
                      onChanged: createStore.setDescription,
                      decoration: InputDecoration(
                        errorText: createStore.descError,
                        labelText: 'Descrição *',
                        labelStyle: labelStyle,
                        contentPadding:
                            const EdgeInsets.fromLTRB(16, 10, 12, 10),
                      ),
                      maxLines: null,
                    ),
                    CategoryField(
                      createStore: createStore,
                    ),
                    CepField(createStore: createStore),
                    Observer(builder: (_) {
                      return TextFormField(
                        onChanged: createStore.setPrice,
                        decoration: InputDecoration(
                          errorText: createStore.priceError,
                          labelText: 'Preço *',
                          labelStyle: labelStyle,
                          contentPadding:
                              const EdgeInsets.fromLTRB(16, 10, 12, 10),
                          prefixText: 'R\$ ',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CentavosInputFormatter(moeda: false),
                        ],
                      );
                    }),
                    HidePhoneField(createStore: createStore),
                    ErrorBox(
                      message: createStore.saveError,
                    ),
                    Observer(builder: (_) {
                      return SizedBox(
                        height: 50,
                        child: GestureDetector(
                          onTap: createStore.invalidSendPressed,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                disabledBackgroundColor: Colors.orangeAccent,
                                backgroundColor: Colors.deepOrange,
                                elevation: 5,
                                tapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap),
                            onPressed: createStore.sendPressed,
                            child: const Text(
                              'Enviar',
                              style:
                                  TextStyle(fontSize: 18, letterSpacing: 0.3),
                            ),
                          ),
                        ),
                      );
                    })
                  ],
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
