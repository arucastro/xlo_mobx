import 'package:flutter/material.dart';

class BarButton extends StatelessWidget {
  const BarButton({Key? key, required this.label, this.decoration, this.onTap}) : super(key: key);


  final String label;
  final BoxDecoration? decoration;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: decoration,
          alignment: Alignment.center,
          height: 40,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: .03
            ),
          ),
        ),
      ),
    );
  }
}
