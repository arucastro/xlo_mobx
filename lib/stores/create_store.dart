import 'dart:ui';

import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/repositories/ad_repository.dart';
import 'package:xlo_mobx/stores/cep_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

import '../models/ad.dart';
import '../models/address.dart';

part 'create_store.g.dart';

class CreateStore = _CreateStore with _$CreateStore;

abstract class _CreateStore with Store {
  ObservableList images = ObservableList();

  @computed
  bool get imagesValid => images.isNotEmpty;

  String? get imagesError {
    if (!showErrors || imagesValid) {
      return null;
    } else {
      return 'Insira imagens.';
    }
  }

  @observable
  String? title = '';

  @action
  void setTitle(String value) => title = value;

  @computed
  bool get titleValid => title!.length >= 6;

  String? get titleError {
    if (!showErrors || titleValid) {
      return null;
    } else if (title!.isEmpty) {
      return 'Campo obrigatório!';
    } else {
      return 'Título muito curto.';
    }
  }

  @observable
  String? description = '';

  @action
  void setDescription(String value) => description = value;

  @computed
  bool get descValid => description!.length >= 10;

  String? get descError {
    if (!showErrors || descValid) {
      return null;
    } else if (description!.isEmpty) {
      return 'Campo obrigatõrio!';
    } else {
      return 'Descrição muito curta.';
    }
  }

  @observable
  Category? category;

  @action
  void setCategory(Category value) => category = value;

  @computed
  bool get categoryValid => category != null;

  String? get categoryError {
    if (!showErrors || categoryValid) {
      return null;
    } else {
      return 'Escolha uma categoria';
    }
  }

  CepStore cepStore = CepStore();

  @computed
  Address? get address => cepStore.address;

  bool get addressValid => address != null;

  String? get addressError {
    if (!showErrors || addressValid) {
      return null;
    } else {
      return 'Campo Obrigatório';
    }
  }

  @observable
  String? priceText = '';

  @action
  void setPrice(String value) => priceText = value;

  @computed
  num? get price {
    if (priceText != null && priceText!.contains(',')) {
      return num.tryParse(priceText!.replaceAll(RegExp('[^0-9]'), ''))! /
          100;
    } else {
      return null;
    }
  }

  bool get priceValid => price != null && price! > 0 && price! <= 9999999;

  String? get priceError {
    if (!showErrors || priceValid) {
      return null;
    } else if (priceText!.isEmpty) {
      return 'Campo obrigatório!';
    } else {
      return 'preço inválido';
    }
  }

  @observable
  bool hidePhone = false;

  @action
  void setHidePhone(bool? value) => hidePhone = value!;

  @computed
  bool get formValid =>
      imagesValid &&
      titleValid &&
      descValid &&
      categoryValid &&
      addressValid &&
      priceValid;

  @computed
  VoidCallback? get sendPressed => formValid ? _sendPressed : null;

  @observable
  bool showErrors = false;

  @action
  void invalidSendPressed() => showErrors = true;

  @observable
  bool loading = false;

  @observable
  String? saveError;

  @action
  Future<void> _sendPressed() async{
    final ad = Ad();
    ad.title = title;
    ad.description = description;
    ad.category = category;
    ad.price = price;
    ad.hidePhone = hidePhone;
    ad.address = address;
    ad.images = images;
    ad.user = GetIt.I<UserManagerStore>().user;

    loading = true;
    try {
      final response = await AdRepository().save(ad);
    } catch (e){
      saveError = e.toString();
    }

    loading = false;
  }
}
