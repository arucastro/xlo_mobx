import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/category.dart';

part 'create_store.g.dart';

class CreateStore = _CreateStore with _$CreateStore;

abstract class _CreateStore with Store {

  ObservableList images = ObservableList();

  @computed
  bool get imagesValid => images.isNotEmpty;
  String? get imagesError {
    if(imagesValid){
      return null;
    }else{
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
    if(titleValid) {
      return null;
    } else if(title!.isEmpty) {
      return 'Campo obrigatório!';
    } else {
      return 'Título muito curto.';
    }
  }

  @observable
  String? description = '';

  @action
  void setDescription(String value) => title = value;

  @computed
  bool get descValid => description!.length >= 10;
  String? get descError {
    if(descValid){
      return null;
    }else if(description!.isEmpty){
      return 'Campo obrigatõrio!';
    }else {
      return 'Descrição muito curta.';
    }
  }

  @observable
  Category? category;

  @action
  void setCategory(Category value) => category = value;

  @observable
  bool hidePhone = false;

  @action
  void setHidePhone(bool? value) => hidePhone = value!;

}