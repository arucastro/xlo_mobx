import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../models/ad.dart';
import 'components/main_panel.dart';

class AdScreen extends StatelessWidget {
  const AdScreen({Key? key, required this.ad}) : super(key: key);

  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Anúncio'),
        centerTitle: true,
      ),
      body: ListView(
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
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MainPanel(ad: ad),
                Divider(color: Colors.black54),
                
              ],
            ),
          )
        ],
      ),
    );
  }
}
