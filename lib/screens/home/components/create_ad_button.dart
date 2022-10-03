import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/stores/page_store.dart';

class CreateAdButton extends StatefulWidget {
  const CreateAdButton({Key? key, required this.scrollController})
      : super(key: key);

  final ScrollController scrollController;

  @override
  State<CreateAdButton> createState() => _CreateAdButtonState();
}

class _CreateAdButtonState extends State<CreateAdButton>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? buttonAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    buttonAnimation = Tween<double>(begin: 0, end: 60).animate(CurvedAnimation(parent: controller!, curve: Curves.easeIn));

    widget.scrollController.addListener(scrollChanged);
  }

  void scrollChanged() {
    final s = widget.scrollController.position;

    if (s.userScrollDirection == ScrollDirection.forward) {
      controller!.forward();
    } else {
      controller!.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: buttonAnimation!,
        builder: (_, __) {
          return Container(
            height: 50,
            margin: EdgeInsets.only(bottom: buttonAnimation!.value),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  backgroundColor: Colors.orange,
                  elevation: 0,
                  alignment: Alignment.center),
              onPressed: () {
                GetIt.I<PageStore>().setPage(1);
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: const [
                  Icon(
                    Icons.camera_alt,
                    size: 40,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Anunciar agora!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
