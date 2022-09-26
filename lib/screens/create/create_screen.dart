import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({Key? key}) : super(key: key);

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
        title: Text('Criar Anúncio'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 50),
        child: SingleChildScrollView(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 16,
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Título *',
                      labelStyle: labelStyle,
                      contentPadding: EdgeInsets.fromLTRB(16, 10, 12, 10),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Descrição *',
                      labelStyle: labelStyle,
                      contentPadding: EdgeInsets.fromLTRB(16, 10, 12, 10),
                    ),
                    maxLines: null,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Preço *',
                      labelStyle: labelStyle,
                      contentPadding: EdgeInsets.fromLTRB(16, 10, 12, 10),
                      prefixText: 'R\$ ',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CentavosInputFormatter(moeda: false),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
