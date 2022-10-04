import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/stores/myads_store.dart';

import 'components/active_tile.dart';

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({Key? key}) : super(key: key);

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> with SingleTickerProviderStateMixin{

  final MyAdsStore myAdsStore = MyAdsStore();

  TabController? tabController;
  static const tabStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus anúncios',),
        centerTitle: true,
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              child: Text('Ativos', style: tabStyle,),
            ),
            Tab(
              child: Text('Pendentes', style: tabStyle,),
            ),
            Tab(
              child: Text('Vendidos', style: tabStyle,),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          Observer(builder: (_){
            if (myAdsStore.activeAds.isEmpty){
              return Container();
            }
            return ListView.builder(
                itemCount: myAdsStore.activeAds.length,
                itemBuilder: (_, index){
                  return ActiveTile(ad: myAdsStore.activeAds[index]);
                }
            );
          }),
          Container(color: Colors.black,),
          Container(color: Colors.green,),
        ],
      ),
    );
  }
}
