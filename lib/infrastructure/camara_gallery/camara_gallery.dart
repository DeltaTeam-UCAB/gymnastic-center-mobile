import 'package:gymnastic_center/application/camara_gallery/camara_gallery.dart';
import 'package:image_picker/image_picker.dart';

class CamaraGalleryServiceImpl extends CamaraGalleryManager {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<String?> selectPhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    if (photo == null) return null;
    return photo.path;
  }

  @override
  Future<String?> takePhoto() async {
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
      preferredCameraDevice: CameraDevice.rear,
    );

    if (photo == null) return null;
    return photo.path;
  }
}
