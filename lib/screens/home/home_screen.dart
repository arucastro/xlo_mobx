import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/stores/home_store.dart';

import '../../components/custom_drawer/custom_drawer.dart';
import 'components/search_dialog.dart';
import 'components/top_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeStore = GetIt.I<HomeStore>();

    openSearch(BuildContext context) async {
      final search = await showDialog(
        context: context,
        builder: (_) => SearchDialog(
          currentSearch: homeStore.search,
        ),
      );
      if (search != null) homeStore.setSearch(search);
    }

    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Observer(builder: (_){
            if (homeStore.search!.isEmpty){
              return Container();
            }else {
              return GestureDetector(
                onTap: () => openSearch(context),
                child: LayoutBuilder(
                  builder: (_, constraints){
                    return Container(
                      width: constraints.biggest.width,
                      child: Text(homeStore.search!),
                    );
                  },
                ),
              );
            }
          }),
          actions: [
            Observer(builder: (_){
              if(homeStore.search!.isEmpty){
                return IconButton(
                  onPressed: () {
                    openSearch(context);
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 30,
                  ),
                );
              }
              return IconButton(
                onPressed: () {
                  homeStore.setSearch('');
                },
                icon: const Icon(
                  Icons.close,
                  size: 30,
                ),
              );
            })
          ],
        ),
        body: Column(
          children: [
            TopBar(),
          ],
        ),
      ),
    );
  }
}
