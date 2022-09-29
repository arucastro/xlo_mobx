import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PriceField extends StatelessWidget {
  const PriceField({Key? key, required this.label, required this.onChanged, this.initialValue}) : super(key: key);

  final String label;
  final Function(int?) onChanged;
  final int? initialValue;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        onChanged: (text){
          onChanged(int.tryParse(text.replaceAll('.', '')));
        },
        decoration: InputDecoration(
          prefixText: 'R\$ ',
          border: OutlineInputBorder(),
          isDense: true,
          labelText: label,
        ),
        initialValue: initialValue?.toString(),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          RealInputFormatter(moeda: false),
        ],
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}
