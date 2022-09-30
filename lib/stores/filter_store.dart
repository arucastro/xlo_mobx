import 'package:mobx/mobx.dart';

part 'filter_store.g.dart';

enum OrderBy {DATE, PRICE}

//constantes deslocadas para poder ter mais de um botão habilitado
const VENDOR_TYPE_PARTICULAR = 1 << 0;
const VENDOR_TYPE_PROFESSIONAL = 1 << 1;

class FilterStore = _FilterStore with _$FilterStore;

abstract class _FilterStore with Store {

  @observable
  OrderBy orderBy = OrderBy.DATE;

  @action
  void setOrderBy(OrderBy value) => orderBy = value;

  @observable
  int? minPrice;

  @action
  void setMinPrice(int? value) => minPrice = value;

  @observable
  int? maxPrice;

  @action
  void setMaxPrice(int? value) => maxPrice = value;

  @computed
  String? get priceError => maxPrice != null && minPrice != null && maxPrice! < minPrice! ?
  'Faixa de preço inválida' : null;

  @observable
  int vendorType = 0;

  @action
  void selectVendorType(int value) => vendorType = value;
  void setVendorType(int type) => vendorType = vendorType | type;
  void resetVendorType(int type) => vendorType = vendorType & ~type;

  //verifica se o tipo de vendedor é diferente de zero
  @computed
  bool get isTypeParticular => (vendorType & VENDOR_TYPE_PARTICULAR) != 0;
  bool get isTypeProfessional => (vendorType & VENDOR_TYPE_PROFESSIONAL) != 0;

}