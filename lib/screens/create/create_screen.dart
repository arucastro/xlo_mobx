import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:get_it/get_it.dart';import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/components/error_box.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/screens/create/components/cep_field.dart';
import 'package:xlo_mobx/stores/create_store.dart';
import 'package:xlo_mobx/stores/page_store.dart';

import 'components/category_field.dart';
import 'components/hide_phone_field.dart';
import 'components/images_field.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key, this.ad}) : super(key: key);

  final Ad? ad;

  @override
  State<CreateScreen> createState() => _CreateScreenState(ad);
}

class _CreateScreenState extends State<CreateScreen> {

  _CreateScreenState(Ad? ad) : editing = ad != null, createStore = CreateStore(ad ?? Ad());

  bool editing = false;

  final CreateStore createStore;

  @override
  void initState() {
    super.initState();

    when((_) => createStore.savedAd, (){
      GetIt.I<PageStore>().setPage(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(
      fontWeight: FontWeight.w500,
      color: Colors.grey,
      fontSize: 18,
    );

    return Scaffold(
      drawer: editing ? null : const CustomDrawer(),
      appBar: AppBar(
        title: Text(editing ? 'Editar anúncio' : 'Criar anúncio'),
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
                      initialValue: createStore.title ?? '',
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
                      initialValue: createStore.description ?? '',
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
                        initialValue: createStore.priceText ?? '',
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
