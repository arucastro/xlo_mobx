import 'package:flutter/material.dart';
import 'package:xlo_mobx/models/ad.dart';

class LocationPanel extends StatelessWidget {
  const LocationPanel({Key? key, required this.ad}) : super(key: key);

  final Ad ad;

  @override
  Widget build(BuildContext context) {
    const stl = TextStyle(fontSize: 17, fontWeight: FontWeight.w400);


    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text(
            'Localização',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('CEP', style: stl),
                  SizedBox(height: 12),
                  Text('Município', style: stl),
                  SizedBox(height: 12),
                  Text('Bairro', style: stl)
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${ad.address!.cep}', style: stl),
                  SizedBox(height: 12),
                  Text('${ad.address!.city!.name}', style: stl),
                  SizedBox(height: 12),
                  Text('${ad.address!.district}', style: stl),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
