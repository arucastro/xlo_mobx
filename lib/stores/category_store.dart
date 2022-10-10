import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/repositories/category_repository.dart';

import '../models/category.dart';
import 'connectivity_store.dart';

part 'category_store.g.dart';

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();

  _CategoryStore() {
    autorun((_) async {
      if (connectivityStore.connected && categoryList.isEmpty) {
        await Future.delayed(Duration(milliseconds: 500)).then((value) {
          _loadCategories();
          error = null;
        });
      }
    });
  }

  ObservableList<Category> categoryList = ObservableList();

  @computed
  List<Category> get allCategoryList => List.from(categoryList)
    ..insert(0, Category(id: '*', description: 'Todas'));

  @observable
  String? error;

  @action
  void setError(String value) => error = value;

  @action
  void setCategories(List<Category> categories) {
    categoryList.clear();
    categoryList.addAll(categories);
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await CategoryRepository().getList();
      setCategories(categories);
    } catch (e) {
      setError(e.toString());
    }
  }
}
