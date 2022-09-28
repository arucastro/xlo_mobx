import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/models/user.dart';
import 'package:xlo_mobx/models/category.dart';

enum AdStatus {PENDING, ACTIVE, SOLD, DELETED}

class Ad {

  String? id;

  List? images;

  String? title;
  String? description;

  Category? category;

  Address? address;
  double? price;
  bool? hidePhone;

  AdStatus? status = AdStatus.PENDING;
  DateTime? created;

  User? user;

  int? views;
}