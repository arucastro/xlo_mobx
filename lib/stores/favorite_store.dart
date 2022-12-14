import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/favorite_repository.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

part 'favorite_store.g.dart';

class FavoriteStore = _FavoriteStore with _$FavoriteStore;

abstract class _FavoriteStore with Store {
  _FavoriteStore() {
    reaction((_) => userManagerStore.isUserLogged, (_) {
      _getFavoritesList();
    });
  }

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  ObservableList<Ad> favoritesList = ObservableList<Ad>();

  @action
  Future<void> toggleFavorite(Ad ad) async {
    try {
      if (favoritesList.any((a) => a.id == ad.id)) {
        favoritesList.removeWhere((a) => a.id == ad.id);
        await FavoriteRepository().delete(ad, userManagerStore.user!);
      } else {
        favoritesList.add(ad);
        await FavoriteRepository().save(ad: ad, user: userManagerStore.user!);
      }
    } catch (e) {
      print(e);
    }
  }

  @action
  Future<void> _getFavoritesList() async{
    try {
      favoritesList.clear();
      final favorites = await FavoriteRepository().getFavorites(userManagerStore.user!);
      favoritesList.addAll(favorites);
    } catch (e) {}
  }
}
