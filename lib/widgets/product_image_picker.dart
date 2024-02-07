import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProductImagePicker extends StatefulWidget {
  const ProductImagePicker({super.key, required this.onPickImage});
  final void Function(File image) onPickImage;
  @override
  State<ProductImagePicker> createState() => _ProductImagePickerState();
}

class _ProductImagePickerState extends State<ProductImagePicker> {
  File? _selectedImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery, maxWidth: 600);

    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pickedImage.path);
    });
    widget.onPickImage(_selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return _selectedImage != null
        ? SizedBox(
            height: size.height * 0.15 + const Size.fromRadius(10).height / 2,
            width: size.width * 0.3 + const Size.fromRadius(10).width / 2,
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Container(
                  height: size.height * 0.15,
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(
                        File(_selectedImage!.path),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _selectedImage = null;
                    });
                  },
                  child: const Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.red,
                      child: Center(
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        : Container(
            height: size.height * 0.15,
            width: size.width * 0.3,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: TextButton.icon(
                onPressed: _takePicture,
                icon: const Icon(Icons.camera),
                label: const Text("Take Picture"),
              ),
            ),
          );
  }
}
