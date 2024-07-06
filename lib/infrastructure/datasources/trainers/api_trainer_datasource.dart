import 'package:dio/dio.dart';
import 'package:gymnastic_center/application/key_value_storage/key_value_storage.dart';
import 'package:gymnastic_center/domain/datasources/trainers/trainers_datasource.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/infrastructure/core/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/mappers/course_mapper.dart';
import 'package:gymnastic_center/infrastructure/mappers/trainer_mapper.dart';
import 'package:gymnastic_center/infrastructure/models/courses/course_response.dart';
import 'package:gymnastic_center/infrastructure/models/trainer/trainer_response.dart';

class ApiTrainersDatasource extends TrainersDataSource {
  final KeyValueStorageService keyValueStorage;
  final dio = Dio(BaseOptions(baseUrl: '${Environment.backendApi}/trainer'));

  ApiTrainersDatasource(this.keyValueStorage){
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await keyValueStorage.getValue<String>('token');
        options.headers['Authorization'] = 'Bearer $token';
        return handler.next(options);
      }
    ));
  }

  Future<Course> getCourseById(String id) async {
    final response = await dio.get('/course/one/$id');
    final courseResponse = CourseResponse.fromJson(response.data);
    return CourseMapper.courseToEntity(courseResponse);
  }
  
  @override
  Future<TrainerDetails> getTrainerById(String trainerId) async {
    final response = await dio.get('/one/$trainerId');
    final trainerResponse = TrainerResponse.fromJson(response.data);
    return TrainerDetails(
      trainer: TrainerMapper.trainerToEntity(trainerResponse), 
      isFollowing: trainerResponse.isFollowed
    );
  }
  
  @override
  Future<bool> toggleFollow(String trainerId) async {
    final response = await dio.post('/toggle/follow/$trainerId');
    return response.data['userFollow'];
  }
}
