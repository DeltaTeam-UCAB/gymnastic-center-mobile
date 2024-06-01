import 'package:gymnastic_center/common/results.dart';
import 'package:gymnastic_center/domain/entities/videos/video.dart';

abstract class VideosRepository {
  Future<Result<Video>> getVideoById(String id);
}
