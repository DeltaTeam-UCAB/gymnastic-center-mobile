import 'package:gymnastic_center/domain/entities/videos/video.dart';
import 'package:gymnastic_center/infrastructure/models/videos/video_apivideo.dart';

class VideoMapper {
  static Video apiVideoToEntity(VideoAPIVideo apiVideo) {
    return Video(
      id: apiVideo.id,
      src: apiVideo.src,
    );
  }
}
