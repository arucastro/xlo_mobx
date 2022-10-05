import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/repositories/ad_repository.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

part 'myads_store.g.dart';

class MyAdsStore = _MyAdsStore with _$MyAdsStore;

abstract class _MyAdsStore with Store {
  _MyAdsStore() {
    _getMyAds();
  }

  @computed
  List<Ad> get activeAds =>
      allAds.where((ad) => ad.status == AdStatus.ACTIVE).toList();

  List<Ad> get pendingAds =>
      allAds.where((ad) => ad.status == AdStatus.PENDING).toList();

  List<Ad> get soldAds =>
      allAds.where((ad) => ad.status == AdStatus.SOLD).toList();

  @observable
  List<Ad> allAds = [];

  @observable
  bool loading = false;

  Future<void> _getMyAds() async {
    final user = GetIt.I<UserManagerStore>().user;

    try {
      loading = true;
      allAds = await AdRepository().getMyAds(user!);
      loading = false;
    } catch (e) {}
  }

  void refresh() => _getMyAds();

  Future<void> soldAd(Ad ad) async{
    loading = true;
    await AdRepository().sold(ad);
    refresh();
  }

  Future<void> deleteAd(Ad ad) async{
    loading = true;
    await AdRepository().deleteAd(ad);
    refresh();
  }
}
