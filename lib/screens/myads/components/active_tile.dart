import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/helpers/extensions.dart';

import '../../../models/ad.dart';

class ActiveTile extends StatelessWidget {
  ActiveTile({Key? key, required this.ad}) : super(key: key);

  final Ad ad;

  final List<MenuChoice> choices = [
    MenuChoice(index: 0, title: 'Editar', iconData: Icons.edit),
    MenuChoice(index: 1, title: 'Vendido!', iconData: Icons.edit),
    MenuChoice(index: 2, title: 'Excluir', iconData: Icons.delete),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 90,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: CachedNetworkImage(
                imageUrl: ad.images!.isEmpty
                    ? 'https://static.thenounproject.com/png/194055-200.png'
                    : ad.images!.first,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ad.title!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      ad.price!.formattedMoney(),
                      style: const TextStyle(fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '${ad.views} visitas',
                      style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                    ),
                  ],
                ),
              ),
            ),
            PopupMenuButton<MenuChoice>(
              onSelected: (choice){
                switch(choice.index){
                  case 0:
                    break;
                  case 1:
                    break;
                  case 2:
                    break;
                }
              },
              itemBuilder: (_) {
                return choices
                    .map((choice) => PopupMenuItem<MenuChoice>(
                          value: choice,
                          child: Row(
                            children: [
                              Icon(
                                choice.iconData,
                                size: 20,
                                color: Colors.purple,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                choice.title,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.purple),
                              )
                            ],
                          ),
                        ))
                    .toList();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MenuChoice {
  MenuChoice(
      {required this.index, required this.title, required this.iconData});

  final int index;
  final String title;
  final IconData iconData;
}
