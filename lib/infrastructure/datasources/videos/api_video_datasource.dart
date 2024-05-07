import 'package:gymnastic_center/application/key_value_storage/key_value_storage.dart';
import 'package:gymnastic_center/domain/datasources/videos/videos_datasource.dart';
import 'package:dio/dio.dart';
import 'package:gymnastic_center/domain/entities/videos/video.dart';
import 'package:gymnastic_center/infrastructure/core/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/mappers/video_mapper.dart';
import 'package:gymnastic_center/infrastructure/models/videos/video_apivideo.dart';

class APIVideoDatasource extends VideosDatasource {
  final KeyValueStorageService keyValueStorage;
  final dio = Dio(BaseOptions(baseUrl: '${Environment.backendApi}/video/one'));
  APIVideoDatasource(KeyValueStorageService keyValueStorageI)
      : keyValueStorage = keyValueStorageI;

  @override
  Future<Video> getVideoById(String id) async {
    final response = await dio.get('/$id',
        options: Options(headers: {
          'auth': await keyValueStorage.getValue<String>('token')
        }));

    final apiVideoResponse = VideoAPIVideo.fromJson(response.data);
    final video = VideoMapper.apiVideoToEntity(apiVideoResponse);

    return video;
  }
}
