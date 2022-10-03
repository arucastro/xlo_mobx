import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/error_box.dart';
import 'package:xlo_mobx/stores/home_store.dart';

import '../../components/custom_drawer/custom_drawer.dart';
import 'components/ad_tile.dart';
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
          title: Observer(builder: (_) {
            if (homeStore.search!.isEmpty) {
              return Container();
            } else {
              return GestureDetector(
                onTap: () => openSearch(context),
                child: LayoutBuilder(
                  builder: (_, constraints) {
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
            Observer(builder: (_) {
              if (homeStore.search!.isEmpty) {
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
            Expanded(
              child: Observer(builder: (_) {
                if (homeStore.error != null) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const[
                      Icon(
                        Icons.error,
                        size: 100,
                        color: Colors.white,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Ocorreu um Erro!',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      )
                    ],
                  );
                }
                if(homeStore.loading){
                  return const Center(child:CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ));
                }
                if(homeStore.adList.isEmpty){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const[
                      Icon(
                        Icons.border_clear,
                        size: 100,
                        color: Colors.white,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Nenhum anúncio encontrado...',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20),
                      )
                    ],
                  );
                }
                return ListView.builder(
                    itemCount: homeStore.adList.length,
                    itemBuilder: (_,index){
                      return AdTile(ad: homeStore.adList[index]);
                    });
              }),
            )
          ],
        ),
      ),
    );
  }
}
