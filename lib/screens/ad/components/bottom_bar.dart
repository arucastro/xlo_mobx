import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xlo_mobx/models/ad.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key, required this.ad}) : super(key: key);

  final Ad ad;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      bottom: 0,
      right: 0,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            height: 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.orange,
            ),
            child: Row(
              children: [
                if (!ad.hidePhone!)
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        final phone =
                            ad.user!.phone!.replaceAll(RegExp('[^0-9]'), '');
                        launchUrl(Uri.parse('tel: $phone'));
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                right: BorderSide(color: Colors.black54))),
                        alignment: Alignment.center,
                        height: 25,
                        child: const Text(
                          'Ligar',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      height: 25,
                      child: const Text(
                        'Chat',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              border: Border(top: BorderSide(color: Colors.grey[500]!)),
            ),
            height: 38,
            alignment: Alignment.center,
            child: Text(
              '${ad.user!.name} (anunciante)',
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}
