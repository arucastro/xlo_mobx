import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/stores/cep_store.dart';

class CepField extends StatelessWidget {
  CepField({Key? key}) : super(key: key);

  final CepStore cepStore = CepStore();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          onChanged: cepStore.setCep,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CepInputFormatter(),
          ],
          decoration: const InputDecoration(
            labelText: 'Cep *',
            labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
              fontSize: 18,
            ),
            contentPadding: EdgeInsets.fromLTRB(16, 10, 12, 10),
          ),
        ),
        Observer(builder: (_) {
          if (cepStore.address == null &&
              cepStore.error == null &&
              !cepStore.loading) {
            return Container();
          } else if (cepStore.address == null && cepStore.error == null) {
            return const LinearProgressIndicator();
          } else if (cepStore.error != null) {
            return Container(
              alignment: Alignment.center,
              color: Colors.redAccent,
              height: 50,
              padding: const EdgeInsets.all(8),
              child: Text(
                cepStore.error!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            final a = cepStore.address;
            return Container(
              alignment: Alignment.center,
              color: Colors.purple.withAlpha(150),
              height: 50,
              child: Text(
                'Localização: ${a!.district}, ${a.city!.name} - ${a.uf!.initials},',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                  fontSize: 17
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
        }),
      ],
    );
  }
}
