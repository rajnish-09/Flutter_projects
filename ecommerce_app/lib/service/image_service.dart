import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageService {
  final ImagePicker imagePicker = ImagePicker();
  File? image;
  Future<void> pickImageFromGallery() async {
    final XFile? picked = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (picked != null) {
      image = File(picked.path);
      // print(image);
    }
  }
}
