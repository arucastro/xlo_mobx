import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/ad.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/repositories/parse_errors.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';

class FavoriteRepository {
  Future<void> save({required Ad ad, required User user}) async {
    final favoriteObject = ParseObject(keyFavoritesTable);

      favoriteObject.set<String>(keyFavoritesOwner, user.id!);
      favoriteObject.set<String>(
          keyFavoritesAd, ad.id!);

      final response = await favoriteObject.save();

      if (!response.success) {
        return Future.error(
            ParseErrors.getDescription(response.error!.code) as String);
      }
  }
}
