import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../models/ad.dart';
import 'components/bottom_bar.dart';
import 'components/description_panel.dart';
import 'components/location_panel.dart';
import 'components/main_panel.dart';
import 'components/user_panel.dart';

class AdScreen extends StatelessWidget {
  const AdScreen({Key? key, required this.ad}) : super(key: key);

  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Anúncio'),
        centerTitle: true,
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
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
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
                    const SizedBox(height: 92),
                  ],
                ),
              )
            ],
          ),
          BottomBar(ad: ad),
        ],
      ),
    );
  }
}
