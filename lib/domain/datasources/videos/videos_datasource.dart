import 'package:gymnastic_center/domain/entities/videos/video.dart';

abstract class VideosDatasource {
  Future<Video> getVideoById(String id);
}
