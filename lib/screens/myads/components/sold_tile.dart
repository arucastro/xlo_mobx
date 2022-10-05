import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/stores/myads_store.dart';

import '../../../models/ad.dart';

class SoldTile extends StatelessWidget {
  SoldTile({Key? key, required this.ad, this.store}) : super(key: key);

  final Ad ad;
  final MyAdsStore? store;

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
            Column(
              children: [
                IconButton(
                    onPressed: (){
                    store?.deleteAd(ad);
                },
                    icon: const Icon(Icons.delete, size: 20,), color: Colors.purple)
              ],
            )
          ],
        ),
      ),
    );
  }
}

