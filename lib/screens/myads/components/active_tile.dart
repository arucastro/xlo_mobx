import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/stores/myads_store.dart';

import '../../../models/ad.dart';
import '../../ad/ad_screen.dart';
import '../../create/create_screen.dart';

class ActiveTile extends StatelessWidget {
  ActiveTile({Key? key, required this.ad, this.store}) : super(key: key);

  final Ad ad;
  final MyAdsStore? store;

  final List<MenuChoice> choices = [
    MenuChoice(index: 0, title: ' Editar', iconData: Icons.edit),
    MenuChoice(index: 1, title: ' Vendido!', iconData: Icons.check),
    MenuChoice(index: 2, title: ' Excluir', iconData: Icons.delete),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => AdScreen(ad: ad)));
      },
      child: Card(
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
                  imageUrl: ad.images.isEmpty
                      ? 'https://static.thenounproject.com/png/194055-200.png'
                      : ad.images.first,
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
                icon: const Icon(Icons.more_vert, color: Colors.purple),
                onSelected: (choice) {
                  switch (choice.index) {
                    case 0:
                      editAd(context);
                      break;
                    case 1:
                      soldAd(context);
                      break;
                    case 2:
                      deleteAd(context);
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
      ),
    );
  }

  Future<void> editAd(BuildContext context) async {
    final success = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CreateScreen(ad: ad)));
    if (success != null && success) {
      store?.refresh();
    }
  }

  void soldAd(BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text('Vendido!'),
              content: Text('Confirmar a venda de ${ad.title}? Esta ação não pode ser desfeita'),
              actions: [
                TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: Navigator.of(context).pop,
                    child: Text(
                      'Cancelar',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    )),
                TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.orange),
                    onPressed: () {
                      Navigator.of(context).pop();
                      store?.soldAd(ad);
                    },
                    child: Text(
                      'Confirmar',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    )),
              ],
            ));
  }

  void deleteAd(BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('EXCLUIR'),
          content: Text('Confirmar a exclusão de ${ad.title}? Esta ação não pode ser desfeita'),
          actions: [
            TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: Navigator.of(context).pop,
                child: Text(
                  'Cancelar',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                )),
            TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  Navigator.of(context).pop();
                  store?.deleteAd(ad);
                },
                child: Text(
                  'Confirmar',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                )),
          ],
        ));
  }
}

class MenuChoice {
  MenuChoice(
      {required this.index, required this.title, required this.iconData});

  final int index;
  final String title;
  final IconData iconData;
}
