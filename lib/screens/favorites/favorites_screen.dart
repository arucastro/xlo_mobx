import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/components/empty_card.dart';
import 'package:xlo_mobx/stores/favorite_store.dart';

import 'components/favorite_tile.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({Key? key, this.hideDrawer = false}) : super(key: key);

  final bool hideDrawer;

  final FavoriteStore favoriteStore = GetIt.I<FavoriteStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: hideDrawer ? null : CustomDrawer(),
      appBar: AppBar(
        title: const Text('Favoritos'),
        centerTitle: true,
      ),
      body: Observer(builder: (_) {
        if (favoriteStore.favoritesList.isEmpty) {
          return Stack(
            fit: StackFit.expand,
            children: [
              EmptyCard(text: 'Nenhum anúncio favoritado...'),
            ],
          );
        } else {
          return ListView.builder(
            padding: const EdgeInsets.all(4),
            itemCount: favoriteStore.favoritesList.length,
            itemBuilder: (_, index) =>
                FavoriteTile(ad: favoriteStore.favoritesList[index]),
          );
        }
      }),
    );
  }
}
