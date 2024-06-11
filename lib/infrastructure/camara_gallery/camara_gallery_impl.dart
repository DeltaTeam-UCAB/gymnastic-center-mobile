import 'dart:convert';

import 'package:gymnastic_center/infrastructure/camara_gallery/camara_gallery_manager.dart';
import 'package:image_picker/image_picker.dart';

class CamaraGalleryImpl extends CamaraGalleryManager {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<String?> selectPhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (photo == null) return null;
    return _convertImageToBase64(photo);
  }

  @override
  Future<String?> takePhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
      preferredCameraDevice: CameraDevice.rear,
    );

    if (photo == null) return null;
    return _convertImageToBase64(photo);
  }

  Future<String> _convertImageToBase64(XFile image) async {
    final imageBytes = await image.readAsBytes();
    return base64Encode(imageBytes);
  }
}
