import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/screens/create/components/image_source_modal.dart';

class ImagesField extends StatelessWidget {
  const ImagesField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onImageSelected(File image){
      Navigator.of(context).pop;
    }

    return Container(
      color: Colors.grey[200],
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: GestureDetector(
              onTap: () {
                if (Platform.isAndroid) {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => ImageSourceModal(onImageSelected: (image){}),
                  );
                } else {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) => ImageSourceModal(onImageSelected: (image){}),
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
        },
      ),
    );
  }
}
