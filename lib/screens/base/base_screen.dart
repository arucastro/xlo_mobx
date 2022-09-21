import 'package:flutter/material.dart';

import '../home/home_screen.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({Key? key}) : super(key: key);

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(),
          Container(color: Colors.yellowAccent),
          Container(color: Colors.green),
          Container(color: Colors.orange),
          Container(color: Colors.blue),
        ],
      ),
    );
  }
}
