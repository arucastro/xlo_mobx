import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/stores/favorite_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

import '../../models/ad.dart';
import 'components/bottom_bar.dart';
import 'components/description_panel.dart';
import 'components/location_panel.dart';
import 'components/main_panel.dart';
import 'components/user_panel.dart';

class AdScreen extends StatelessWidget {
  AdScreen({Key? key, required this.ad}) : super(key: key);
  final currentUser = GetIt.I<UserManagerStore>().user;
  final Ad ad;

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
  final FavoriteStore favoriteStore = GetIt.I<FavoriteStore>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Anúncio'),
        centerTitle: true,
        actions: [
          if (ad.status == AdStatus.ACTIVE && userManagerStore.isUserLogged)
            Observer(builder: (_){
              return IconButton(
                  onPressed: () => favoriteStore.toggleFavorite(ad),
                  icon: Icon(favoriteStore.favoritesList.any((a) => a.id == ad.id) ? Icons.star : Icons.star_border));
            })
        ],
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              CarouselSlider(
                items: ad.images!
                    .map((url) => CachedNetworkImage(imageUrl: url))
                    .toList(),
                options: CarouselOptions(
                  height: 360,
                  autoPlay: false,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MainPanel(ad: ad),
                    const Divider(color: Colors.black54, height: 2),
                    DescriptionPanel(ad: ad),
                    const Divider(color: Colors.black54, height: 2),
                    LocationPanel(ad: ad),
                    const Divider(color: Colors.black54, height: 2),
                    UserPanel(ad: ad),
                    if (userManagerStore.isUserLogged)
                      SizedBox(
                          height: ad.status == AdStatus.PENDING ||
                                  currentUser!.id! == ad.user!.id
                              ? 0
                              : 92),
                  ],
                ),
              )
            ],
          ),
          if (userManagerStore.isUserLogged && currentUser!.id! != ad.user!.id)
            BottomBar(ad: ad),
        ],
      ),
    );
  }
}
