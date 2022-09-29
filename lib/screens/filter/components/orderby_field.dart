import 'package:flutter/material.dart';
import 'package:xlo_mobx/screens/filter/components/section_title.dart';

class OrderByField extends StatelessWidget {
  const OrderByField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget buildOption(String title) {
      return Container(
        width: 80,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.purple, borderRadius: BorderRadius.circular(25)),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Ordenar por'),
        Row(
          children: [
            buildOption('Data'),
            const SizedBox(width: 20),
            buildOption('Preço'),
          ],
        )
      ],
    );
  }
}
