import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/category/category_screen.dart';
import 'package:xlo_mobx/stores/create_store.dart';

class CategoryField extends StatelessWidget {
  const CategoryField({Key? key, required this.createStore}) : super(key: key);

  final CreateStore createStore;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return ListTile(
        title: Text(
          'Categoria *',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey,
            fontSize: createStore.category == null ? 18 : 15,
          ),
        ),
        subtitle: createStore.category == null
            ? null
            : Text(
                '${createStore.category!.description}',
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
        trailing: const Icon(Icons.category),
        onTap: () async {
          final category = await showDialog(
              context: context,
              builder: (context) => CategoryScreen(
                    showAll: false,
                    selected: createStore.category,
                  ));
          if (category != null) {
            createStore.setCategory(category);
          }
        },
      );
    });
  }
}
