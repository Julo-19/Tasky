import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageService {
  static final ImagePicker _picker = ImagePicker();

  // Ouvre galerie
  static Future<String?> pickImageAsBase64() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 256,
      maxHeight: 256,
      imageQuality: 40,
    );

    if (picked == null) return null;

    final bytes = await File(picked.path).readAsBytes();
    return base64Encode(bytes);
  }
}