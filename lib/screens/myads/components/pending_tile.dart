import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/helpers/extensions.dart';
import 'package:xlo_mobx/screens/ad/ad_screen.dart';

import '../../../models/ad.dart';

class PendingTile extends StatelessWidget {
  const PendingTile({Key? key, required this.ad}) : super(key: key);

  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => AdScreen(ad: ad)));
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
                        'AGUARDANDO APROVAÇÃO',
                        style: TextStyle(fontSize: 12, color: Colors.grey[800]),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

