import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ImageService {
  final imagePicker = ImagePicker();
  File? image;
  final String cloudName = 'dviarrjbt';
  final String presetName = 'Ecommerce';

  Future<File?> pickImageFromGallery() async {
    final XFile? picked = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (picked != null) {
      image = File(picked.path);
      return image;
    }
    return null;
  }

  Future<File?> pickImageFromCamera() async {
    final XFile? picked = await imagePicker.pickImage(
      source: ImageSource.camera,
    );
    if (picked != null) {
      image = File(picked.path);
      return image;
    }
    return null;
  }

  Future<String> uploadImage(File? file) async {
    try {
      final String url =
          'https://api.cloudinary.com/v1_1/$cloudName/image/upload';
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['upload_preset'] = presetName;
      request.files.add(await http.MultipartFile.fromPath('file', file!.path));
      var response = await request.send();
      var res = await http.Response.fromStream(response);
      var data = jsonDecode(res.body);
      final String imageUrl = data['secure_url'];
      return imageUrl;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
