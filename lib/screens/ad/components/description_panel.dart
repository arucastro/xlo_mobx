import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:xlo_mobx/models/ad.dart';

class DescriptionPanel extends StatelessWidget {
  const DescriptionPanel({Key? key, required this.ad}) : super(key: key);

  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text(
            'Descrição',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: ReadMoreText(
            textAlign: TextAlign.justify,
            ad.description!,
            style: const TextStyle(fontSize: 16),
            trimLines: 2,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Mostrar mais',
            trimExpandedText: '\nMostrar menos',
            moreStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.purple),
            lessStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.purple),
          ),
        ),
      ],
    );
  }
}
