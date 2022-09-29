import 'package:flutter/material.dart';

import '../../components/custom_drawer/custom_drawer.dart';
import 'components/search_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    openSearch(BuildContext context) async{
     final search = await showDialog(context: context, builder: (_) => SearchDialog());
     print(search);
    }

    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                openSearch(context);
              },
              icon: const Icon(
                Icons.search,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
