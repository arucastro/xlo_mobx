import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/stores/create_store.dart';

class HidePhoneField extends StatelessWidget {
  const HidePhoneField({Key? key, required this.createStore}) : super(key: key);

  final CreateStore createStore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Observer(builder: (_){
        return Row(
          children: [
            Checkbox(value: createStore.hidePhone, onChanged: createStore.setHidePhone),
            Expanded(
              child: Text(
                'Ocultar telefone neste anúncio',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: createStore.hidePhone ? Colors.grey[700] : Colors.grey,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
