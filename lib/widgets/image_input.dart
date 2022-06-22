import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as path; // for Construction or combining path
import 'package:path_provider/path_provider.dart'
    as sys_paths; // for finding path

class ImageInput extends StatefulWidget {
  

  ImageInput({Key? key,  this.onSelectImage}) : super(key: key);
  final Function? onSelectImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  final _picker = ImagePicker();
  Future<void> _takePicture() async {
    // ImagePicker
    print("Image Picker");
    final imageFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 600,
    );
    setState(
      () {
        _storedImage = File(imageFile!.path); // convert XFile to regular file
      },
    );
    final appDir = await sys_paths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile!.path);
    final imageFilePatch = imageFile as File;
    final savedImage = await imageFilePatch.copy('${appDir.path}/$fileName');
    widget.onSelectImage!(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            icon: const Icon(Icons.camera),
            label: const Text('Take Picture'),
            style: TextButton.styleFrom(
              primary: Theme.of(context).colorScheme.primary,
            ),
            onPressed: _takePicture,
          ),
        )
      ],
    );
  }
}
