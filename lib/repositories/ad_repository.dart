import 'package:xlo_mobx/models/ad.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:path/path.dart' as path;
import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/models/uf.dart';

import 'dart:io';

import 'package:xlo_mobx/repositories/parse_errors.dart';
import 'package:xlo_mobx/repositories/table_keys.dart';
import 'package:xlo_mobx/repositories/user_repository.dart';

import '../models/city.dart';

class AdRepository {
  Future<void> save(Ad ad) async {
    try {
      final parseImages = await saveImages(ad.images!);

      final parseUser = await ParseUser.currentUser() as ParseUser;

      final adObject = ParseObject(keyAdTable);

      final parseAcl = ParseACL(owner: parseUser);
      parseAcl.setPublicReadAccess(allowed: true);
      parseAcl.setPublicWriteAccess(allowed: false);
      adObject.setACL(parseAcl);

      adObject.set<String>(keyAdTitle, ad.title!);
      adObject.set<String>(keyAdDescription, ad.description!);
      adObject.set<bool>(keyAdHidePhone, ad.hidePhone!);
      adObject.set<num>(keyAdPrice, ad.price!);
      adObject.set<int>(keyAdStatus, ad.status.index);

      adObject.set<String>(keyAdDistrict, ad.address!.district!);
      adObject.set<String>(keyAdCity, ad.address!.city!.name!);
      adObject.set<String>(keyAdFederativeUnit, ad.address!.uf!.initials!);
      adObject.set<String>(keyAdPostalCode, ad.address!.cep!);

      adObject.set<List<ParseFile>>(keyAdImages, parseImages);

      adObject.set<ParseUser>(keyAdOwner, parseUser);

      adObject.set<ParseObject>(keyAdCategory, ParseObject(keyCategoryTable)
        ..set(keyCategoryId, ad.category!.id));

      final response = await adObject.save();

      if (!response.success) {
        return Future.error(
            ParseErrors.getDescription(response.error!.code) as String);
      }
    }catch (e){
      return Future.error('Falha ao salvar anúncio');
    }
  }

  /*Ad mapParseAd(ParseObject object){
    return Ad(
      id: object.objectId,
      title: object.get<String>(keyAdTitle),
      description: object.get<String>(keyAdDescription),
      images: object.get<List>(keyAdImages)?.map((e) => e.url).toList(),
      hidePhone: object.get<bool>(keyAdHidePhone),
      price: object.get<num>(keyAdPrice),
      created: object.createdAt,
      address: Address(
        district: object.get<String>(keyAdDistrict),
        city: City(name: object.get<String>(keyAdCity)),
        cep: object.get<String>(keyAdPostalCode),
        uf: UF(initials: object.get<String>(keyAdFederativeUnit)),
      ),
      category: Category.fromParse(object.get<ParseObject>(keyAdCategory)!),
      user: UserRepository().mapParseUser(object.get<ParseUser>(keyAdOwner)!),
      views: object.get<int>(keyAdViews),
      status: AdStatus.values[object.get<int>(keyAdStatus)!],
    );
  }*/

  Future<List<ParseFile>> saveImages(List images) async {
    final parseImages = <ParseFile>[];
    try {
      for (final image in images) {
        if (image is File) {
          final parseFile = ParseFile(image, name: path.basename(image.path));
          final response = await parseFile.save();
          if (!response.success) {
            return Future.error(
                ParseErrors.getDescription(response.error!.code) as String);
          }
          parseImages.add(parseFile);
        } else {
          final parseFile = ParseFile(null);
          parseFile.name = path.basename(image);
          parseFile.url = image;
          parseImages.add(parseFile);
        }
      }
      return parseImages;
    } catch (e) {
      return Future.error('Falha ao salvar imagens');
    }
  }
}
