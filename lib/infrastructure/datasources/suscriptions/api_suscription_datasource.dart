import 'package:dio/dio.dart';
import 'package:gymnastic_center/application/key_value_storage/key_value_storage.dart';
import 'package:gymnastic_center/domain/datasources/suscription/suscription_datasource.dart';
import 'package:gymnastic_center/domain/entities/suscription/course_progress.dart';
import 'package:gymnastic_center/infrastructure/core/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/mappers/course_progress_mapper.dart';
import 'package:gymnastic_center/infrastructure/models/suscriptions/course_progress_apiresponse.dart';

class APISuscriptionDatasource extends SuscriptionsDatasource {
  final KeyValueStorageService keyValueStorage;
  final dio = Dio(BaseOptions(baseUrl: '${Environment.backendApi}/progress'));

  APISuscriptionDatasource(this.keyValueStorage) {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      final token = await keyValueStorage.getValue<String>('token');
      options.headers['Authorization'] = 'Bearer $token';
      return handler.next(options);
    }));
  }

  @override
  Future<CourseProgress> getProgressByCourseId(String courseId) async {
    final response = await dio.get('/one/$courseId');
    final apiCouseProgressReponse =
        CourseProgressApiResponse.fromJson(response.data);
    final courseProgress =
        CourseProgressMapper.apiResponsetoEntity(apiCouseProgressReponse);
    return courseProgress;
  }

  @override
  Future<void> suscribeToCourse(String courseId) async {
    await dio.post('/start/$courseId');
  }

  @override
  Future<void> markCompletedProgressLesson(
      String courseId, String lessonId) async {
    final Map<String, dynamic> body = {
      "courseId": courseId,
      "markAsCompleted": true,
      "lessonId": lessonId,
      "time": 0,
      "totalTime": 0
    };

    await dio.post('/mark/end', data: body);
  }

  @override
  Future<void> markEndProgressLesson(String courseId, String lessonId,
      int totalSeconds, int viewedSeconds) async {
    final Map<String, dynamic> body = {
      "courseId": courseId,
      "markAsCompleted": false,
      "lessonId": lessonId,
      "time": viewedSeconds,
      "totalTime": totalSeconds
    };

    await dio.post('/mark/end', data: body);
  }

  @override
  Future<List<CourseProgress>> getSuscribedCourses(int page,
      {int? perPage = 5}) async {
    final Map<String, dynamic> body = {"page": page, "perPage": perPage};
    final response = await dio.get('/courses', queryParameters: body);
    final List<CourseProgress> coursesSuscribed = [];
    for (final courseSuscribedResponse in response.data ?? []) {
      final coursesProgressApi =
          CourseProgressApiResponse.fromJson(courseSuscribedResponse);
      coursesSuscribed
          .add(CourseProgressMapper.apiResponsetoEntity(coursesProgressApi));
    }
    return coursesSuscribed;
  }

  @override
  Future<void> unsuscribeCourse(String courseId) async {
    await dio.delete('/one/$courseId');
  }

  @override
  Future<CourseProgress> getTrendingCourse() async {
    final response = await dio.get('/trending');
    final apiCouseProgressReponse =
        CourseProgressApiResponse.fromJson(response.data);
    final courseProgress =
        CourseProgressMapper.apiResponsetoEntity(apiCouseProgressReponse);
    return courseProgress;
  }

  @override
  Future<int> getSuscribedCoursesCount() async {
    final response = await dio.get('/count/client');
    return response.data["count"];
  }
}
