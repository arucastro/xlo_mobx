import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/error_box.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/stores/category_store.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({Key? key, this.selected, this.showAll = true})
      : super(key: key);

  final Category? selected;
  final bool showAll;
  final CategoryStore categoryStore = GetIt.I<CategoryStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Categorias'),
      ),
      body: Center(
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 16,
            margin: const EdgeInsets.all(25),
            child: Observer(builder: (_) {
              if (categoryStore.error != null) {
                return ErrorBox(
                  message: categoryStore.error,
                );
              } else if (categoryStore.categoryList.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else {
                final categories = showAll
                    ? categoryStore.allCategoryList
                    : categoryStore.categoryList;
                return ListView.separated(
                  separatorBuilder: (_, __) {
                    return const Divider(
                      height: 2,
                      color: Colors.grey,
                    );
                  },
                  itemCount: categories.length,
                  itemBuilder: (_, index) {
                    final category = categories[index];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pop(category);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        color: category.id == selected?.id
                            ? Colors.purple.withAlpha(50)
                            : null,
                        child: Text(
                          category.description!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: category.id == selected?.id
                                ? FontWeight.bold
                                : null,
                            color: category.id == selected?.id
                                ? Colors.purple
                                : null,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            })),
      ),
    );
  }
}
