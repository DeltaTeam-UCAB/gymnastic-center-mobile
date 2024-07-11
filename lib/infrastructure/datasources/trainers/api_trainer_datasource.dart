import 'package:dio/dio.dart';
import 'package:gymnastic_center/application/key_value_storage/key_value_storage.dart';
import 'package:gymnastic_center/domain/datasources/trainers/trainers_datasource.dart';
import 'package:gymnastic_center/infrastructure/core/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/mappers/trainer_mapper.dart';
import 'package:gymnastic_center/infrastructure/models/trainer/trainer_response.dart';

class ApiTrainersDatasource extends TrainersDataSource {
  final KeyValueStorageService keyValueStorage;
  final dio = Dio(BaseOptions(baseUrl: Environment.backendApi));

  ApiTrainersDatasource(this.keyValueStorage) {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      final token = await keyValueStorage.getValue<String>('token');
      options.headers['Authorization'] = 'Bearer $token';
      return handler.next(options);
    }));
  }

  Future<int> _getBlogCount(String trainerId) async {
    final response = await dio.get('/blog/count?trainer=$trainerId');
    return response.data['count'];
  }

  Future<int> _getCourseCount(String trainerId) async {
    final response = await dio.get('/course/count?trainer=$trainerId');
    return response.data['count'];
  }

  @override
  Future<TrainerDetails> getTrainerById(String trainerId) async {
    final blogCount = await _getBlogCount(trainerId);
    final courseCount = await _getCourseCount(trainerId);

    final response = await dio.get('/trainer/one/$trainerId');
    final trainerResponse = TrainerResponse.fromJson(response.data);

    return TrainerDetails(
        trainer: TrainerMapper.trainerToEntity(trainerResponse),
        isFollowing: trainerResponse.isFollowed,
        blogCount: blogCount,
        courseCount: courseCount);
  }

  @override
  Future<bool> toggleFollow(String trainerId) async {
    final response = await dio.post('/trainer/toggle/follow/$trainerId');
    return response.data['userFollow'] ?? true;
  }

  @override
  Future<List<TrainerDetails>> getTrainersPaginated(
      {int page = 1, int perPage = 10, bool filterByFollowed = false}) async {
    final response = await dio.get(
      '/trainer/many',
      queryParameters: {
        'page': page,
        'perPage': perPage,
        'filterByFollowed': filterByFollowed,
      },
    );

    final trainers = (response.data as List).map((data) {
      final apiTrainerResponse = TrainerResponse.fromJson(data);
      final trainer = TrainerMapper.trainerToEntity(apiTrainerResponse);
      return TrainerDetails(trainer: trainer, isFollowing: apiTrainerResponse.isFollowed);
    }).toList();

    return trainers;
  }
  
  @override
  Future<String> deleteTrainer(String trainerId) async {
    final response = await dio.delete('/trainer/one/$trainerId');
    return response.data['id'] ?? '';
  } 
}
