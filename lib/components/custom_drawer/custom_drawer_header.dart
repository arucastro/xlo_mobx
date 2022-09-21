import 'package:flutter/material.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      height: 95,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Icon(
            Icons.person,
            color: Colors.white,
            size: 35,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Acesse sua conta!',
                  style: const TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.w700),
                ),
                Text(
                  'Clique aqui.',
                  style: const TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.w500),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
