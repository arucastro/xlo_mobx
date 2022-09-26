import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/create/components/image_source_modal.dart';
import 'package:xlo_mobx/stores/create_store.dart';

import 'image_dialog.dart';

class ImagesField extends StatelessWidget {
  const ImagesField({Key? key, required this.createStore}) : super(key: key);

  final CreateStore createStore;

  @override
  Widget build(BuildContext context) {
    void onImageSelected(File image) {
      createStore.images.add(image);
      Navigator.of(context).pop();
    }

    return Container(
      color: Colors.grey[200],
      height: 120,
      child: Observer(builder: (_) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount:
              createStore.images.length < 5 ? createStore.images.length + 1 : 5,
          itemBuilder: (_, index) {
            if (index == createStore.images.length) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: GestureDetector(
                  onTap: () {
                    if (Platform.isAndroid) {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) =>
                            ImageSourceModal(onImageSelected: onImageSelected),
                      );
                    } else {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) =>
                            ImageSourceModal(onImageSelected: onImageSelected),
                      );
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[400],
                    radius: 45,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.camera_alt,
                          size: 50,
                          color: Colors.white70,
                        ),
                        Text(
                          'Inserir',
                          style: TextStyle(color: Colors.white70),
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => ImageDialog(
                        image: createStore.images[index],
                        onDelete: () => createStore.images.removeAt(index),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    backgroundImage: FileImage(createStore.images[index]),
                    radius: 45,
                  ),
                ),
              );
            }
          },
        );
      }),
    );
  }
}
