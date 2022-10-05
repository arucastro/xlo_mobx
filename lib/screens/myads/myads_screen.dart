import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/components/empty_card.dart';
import 'package:xlo_mobx/stores/myads_store.dart';

import 'components/active_tile.dart';
import 'components/pending_tile.dart';
import 'components/sold_tile.dart';

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({Key? key, this.initialPage = 0}) : super(key: key);

  final int initialPage;

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen>
    with SingleTickerProviderStateMixin {
  final MyAdsStore myAdsStore = MyAdsStore();

  TabController? tabController;
  static const tabStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: 3, vsync: this, initialIndex: widget.initialPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meus anúncios',
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(
              child: Text(
                'Ativos',
                style: tabStyle,
              ),
            ),
            Tab(
              child: Text(
                'Pendentes',
                style: tabStyle,
              ),
            ),
            Tab(
              child: Text(
                'Vendidos',
                style: tabStyle,
              ),
            ),
          ],
        ),
      ),
      body: Observer(builder: (_) {
        if (myAdsStore.loading) {
          return const Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white)));
        }
          return TabBarView(
            controller: tabController,
            children: [
              Observer(builder: (_) {
                if (myAdsStore.activeAds.isEmpty) {
                  return EmptyCard(text: 'Você não possui nenhum anúncio ativo');
                }
                return ListView.builder(
                    itemCount: myAdsStore.activeAds.length,
                    itemBuilder: (_, index) {
                      return ActiveTile(
                          ad: myAdsStore.activeAds[index], store: myAdsStore);
                    });
              }),
              Observer(builder: (_) {
                if (myAdsStore.pendingAds.isEmpty) {
                  return EmptyCard(text: 'Você não possui nenhum anúncio pendente para aprovação');
                }
                return ListView.builder(
                    itemCount: myAdsStore.pendingAds.length,
                    itemBuilder: (_, index) {
                      return PendingTile(ad: myAdsStore.pendingAds[index]);
                    });
              }),
              Observer(builder: (_) {
                if (myAdsStore.soldAds.isEmpty) {
                  return EmptyCard(text: 'Nenhum anúncio foi vendido ainda...');
                }
                return ListView.builder(
                    itemCount: myAdsStore.soldAds.length,
                    itemBuilder: (_, index) {
                      return SoldTile(ad: myAdsStore.soldAds[index], store: myAdsStore,);
                    });
              }),
            ],
          );

      }),
    );
  }
}
