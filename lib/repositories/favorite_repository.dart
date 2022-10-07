import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/parse_errors.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';

class FavoriteRepository {
  Future<void> save({required Ad ad, required User user}) async {
    final favoriteObject = ParseObject(keyFavoritesTable);
    final parseAd = ParseObject(keyAdTable)..set<String>(keyAdId, ad.id!);

    favoriteObject.set<String>(keyFavoritesOwner, user.id!);
    favoriteObject.set(keyFavoritesAd, parseAd.toPointer());
    final response = await favoriteObject.save();

    if (!response.success) {
      return Future.error(
          ParseErrors.getDescription(response.error!.code) as String);
    }
  }

  Future<void> delete(Ad ad, User user) async {
    try {
      final queryBuilder =
          QueryBuilder<ParseObject>(ParseObject(keyFavoritesTable));

      queryBuilder.whereEqualTo(keyFavoritesOwner, user.id);
      queryBuilder.whereEqualTo(keyFavoritesAd, ParseObject(keyAdTable)..set<String>(keyAdId, ad.id!));

      final response = await queryBuilder.query();

      if (response.success && response.results != null) {
        for (final f in response.results as List<ParseObject>) {
          await f.delete();
        }
      }
    } catch (e) {
      return Future.error('Falha ao deletar favorito');
    }
  }
}
