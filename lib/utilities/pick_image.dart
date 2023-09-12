// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

selectImages(
  BuildContext context,
  WidgetRef ref,
  File? image,
) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Select Image'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text('Gallery'),
                  onTap: () async {
                    final _image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);

                    setState(() {
                      image = _image != null ? File(_image.path) : null;
                    });
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  child: const Text('Camera'),
                  onTap: () async {
                    final _image = await ImagePicker()
                        .pickImage(source: ImageSource.camera);

                    setState(() {
                      image = _image != null ? File(_image.path) : null;
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
