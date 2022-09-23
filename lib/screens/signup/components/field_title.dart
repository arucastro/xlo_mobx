import 'package:flutter/material.dart';

class FieldTitle extends StatelessWidget {
  const FieldTitle({Key? key, required this.title, this.subtitle})
      : super(key: key);

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 3),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          Text(
            subtitle != null ? subtitle! : '',
            style: TextStyle(
              color: Colors.grey[700],
            ),
          )
        ],
      ),
    );
  }
}
