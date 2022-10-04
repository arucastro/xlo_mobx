import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/models/uf.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/models/category.dart';

import '../repositories/table_keys.dart';
import '../repositories/user_repository.dart';
import 'city.dart';

enum AdStatus {PENDING, ACTIVE, SOLD, DELETED}

class Ad {

  Ad.fromParseObject(ParseObject object){
    id = object.objectId;
    title = object.get<String>(keyAdTitle);
    description = object.get<String>(keyAdDescription);
    images = object.get<List>(keyAdImages)!.map((e) => e.url).toList();
    hidePhone = object.get<bool>(keyAdHidePhone);
    price = object.get<num>(keyAdPrice);
    created = object.createdAt;
    address = Address(
    district: object.get<String>(keyAdDistrict),
    city: City(name: object.get<String>(keyAdCity)),
    cep: object.get<String>(keyAdPostalCode),
    uf: UF(initials: object.get<String>(keyAdFederativeUnit))
    );
    category = Category.fromParse(object.get<ParseObject>(keyAdCategory)!);
    user = UserRepository().mapParseUser(object.get<ParseUser>(keyAdOwner)!);
    views = object.get<int>(keyAdViews);
    status = AdStatus.values[object.get<int>(keyAdStatus)!];
  }

  Ad({
      this.id,
      this.images = const [],
      this.title,
      this.description,
      this.category,
      this.address,
      this.price,
      this.hidePhone,
      this.status = AdStatus.PENDING,
      this.created,
      this.user,
      this.views});

  String? id;

  List images = [];

  String? title;
  String? description;

  Category? category;

  Address? address;
  num? price;
  bool? hidePhone = false;

  AdStatus status = AdStatus.PENDING;
  DateTime? created;

  User? user;

  int? views;
}