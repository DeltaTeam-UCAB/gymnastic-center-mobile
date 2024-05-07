import 'package:gymnastic_center/application/core/results.dart';
import 'package:gymnastic_center/domain/datasources/videos/videos_datasource.dart';
import 'package:gymnastic_center/domain/entities/videos/video.dart';
import 'package:gymnastic_center/domain/repositories/videos/videos_repository.dart';

class VideoRepositoryImpl extends VideosRepository {
  final VideosDatasource videosDatasource;

  VideoRepositoryImpl(this.videosDatasource);

  @override
  Future<Result<Video>> getVideoById(String id) async {
    try {
      final video = await videosDatasource.getVideoById(id);
      return Result<Video>.success(video);
    } catch (error, _) {
      return Result<Video>.fail(error as Exception);
    }
  }
}
