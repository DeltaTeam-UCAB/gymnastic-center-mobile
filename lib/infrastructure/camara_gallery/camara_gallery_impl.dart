import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:gymnastic_center/infrastructure/camara_gallery/camara_gallery_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CamaraGalleryImpl extends CamaraGalleryManager {
  final ImagePicker _picker = ImagePicker();
  final ImageCropper _recort = ImageCropper();

  @override
  Future<String?> selectPhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (photo == null) return null;
    final String? base64Image = await _recortImage(photo.path);
    return base64Image;
  }

  @override
  Future<String?> takePhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
      preferredCameraDevice: CameraDevice.rear,
    );

    if (photo == null) return null;
    final String? base64Image = await _recortImage(photo.path);
    return base64Image;
  }

  Future<String> _converToBase64(Uint8List bytes) async {
    return base64Encode(bytes);
  }

  Future<String?> _recortImage(String pathImage) async {
    final CroppedFile? croppedFile = await _recort.cropImage(
        cropStyle: CropStyle.circle,
        sourcePath: pathImage,
        compressQuality: 100,
        aspectRatioPresets: [
          CropAspectRatioPreset.ratio3x2
        ],
        uiSettings: [
          IOSUiSettings(),
          AndroidUiSettings(
            cropGridColor: Colors.transparent,
            cropFrameColor: Colors.transparent,
            hideBottomControls: true,
          ),
        ]);

    if (croppedFile == null) return null;
    final bytes = await _compressFile(croppedFile.path);
    if (bytes != null) return null;
    return _converToBase64(bytes!);
  }

  Future<Uint8List?> _compressFile(String file) async {
    return await FlutterImageCompress.compressWithFile(
      file,
      minWidth: 300,
      minHeight: 300,
      quality: 80,
    );
  }
}
