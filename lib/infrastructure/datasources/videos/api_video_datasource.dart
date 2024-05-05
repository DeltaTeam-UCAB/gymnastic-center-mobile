import 'package:gymnastic_center/domain/datasources/videos/videos_datasource.dart';
import 'package:dio/dio.dart';
import 'package:gymnastic_center/domain/entities/videos/video.dart';
import 'package:gymnastic_center/infrastructure/core/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/mappers/video_mapper.dart';
import 'package:gymnastic_center/infrastructure/models/videos/video_apivideo.dart';


class APIVideoDatasource extends VideosDatasource{
  
  
  final dio = Dio( BaseOptions(
    baseUrl: '${Environment.backendApi}/api/video/one',
    headers: {
      //TODO: Extraer el token de autenticacion de un localstorage 
      // 'auth' : 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ImRhYWM4ZTJlLWMxY2QtNDk4Yy04NDNjLWI0MGIwMzA4MzNmYSIsImlhdCI6MTcxNDU2NDQ5NH0.OMykx39ocOShdQa72PpNdlDwokiaxStc9D_UE_QUvTk'
      } 
    )
  );
  
  @override
  Future<Video> getVideoById(String id) async{
    final response = await dio.get('/$id');
              
    final apiVideoResponse = VideoAPIVideo.fromJson(response.data);
    final video = VideoMapper.apiVideoToEntity(apiVideoResponse);

    return video;
  }
}