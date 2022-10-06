import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/empty_card.dart';
import 'package:xlo_mobx/components/error_box.dart';
import 'package:xlo_mobx/stores/home_store.dart';

import '../../components/custom_drawer/custom_drawer.dart';
import 'components/ad_tile.dart';
import 'components/create_ad_button.dart';
import 'components/search_dialog.dart';
import 'components/top_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();

  final homeStore = GetIt.I<HomeStore>();


  @override
  void initState() {
    super.initState();
    homeStore.resetPage();
  }

  @override
  Widget build(BuildContext context) {
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
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Observer(builder: (_) {
                    if (homeStore.error != null) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
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
                    if (homeStore.showProgress) {
                      return const Center(
                          child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ));
                    }
                    if (homeStore.adList.isEmpty) {
                      return EmptyCard(text: 'Nenhum anúncio encontrado...');
                    }
                    return ListView.builder(
                        controller: scrollController,
                        itemCount: homeStore.itemCount,
                        itemBuilder: (_, index) {
                          if (index < homeStore.adList.length) {
                            return AdTile(ad: homeStore.adList[index]);
                          }
                          homeStore.loadNextPage();
                          return const SizedBox(
                            height: 10,
                            child: LinearProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.purple),
                            ),
                          );
                        });
                  }),
                  Positioned(
                    left: 100,
                    bottom: -50,
                    child: CreateAdButton(scrollController: scrollController),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
