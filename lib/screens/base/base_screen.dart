import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/screens/account/account_screen.dart';
import 'package:xlo_mobx/screens/favorites/favorites_screen.dart';
import 'package:xlo_mobx/stores/connectivity_store.dart';

import '../../models/ad.dart';
import '../../stores/page_store.dart';
import '../create/create_screen.dart';
import '../home/home_screen.dart';
import '../offline/offline_screen.dart';

class BaseScreen extends StatefulWidget {
  BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

  final PageStore pageStore = GetIt.I<PageStore>();
  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();

  @override
  void initState() {
    super.initState();

    reaction(
      (_) => pageStore.page,
      (page) => pageController.jumpToPage(page),
    );

    autorun((_) {
      if (!connectivityStore.connected) {
        Future.delayed(Duration(milliseconds: 50)).then((value) {
          showDialog(context: context, builder: (_) => OfflineScreen());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(),
          CreateScreen(),
          Container(color: Colors.green),
          FavoritesScreen(),
          AccountScreen(),
        ],
      ),
    );
  }
}
