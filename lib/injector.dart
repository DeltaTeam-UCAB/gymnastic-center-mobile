import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/auth/login/login_bloc.dart';
import 'package:gymnastic_center/application/auth/recover_password/recover_password_bloc.dart';
import 'package:gymnastic_center/application/auth/register/register_bloc.dart';
import 'package:gymnastic_center/application/auth/update/update_bloc.dart';
import 'package:gymnastic_center/application/blogs/bloc/blogs_bloc.dart';
import 'package:gymnastic_center/application/blogs/blog-details/blog_details_bloc.dart';
import 'package:gymnastic_center/application/blogs/delete-blog/delete_blog_bloc.dart';
import 'package:gymnastic_center/application/categories/bloc/categories_bloc.dart';
import 'package:gymnastic_center/application/clients/bloc/clients_bloc.dart';
import 'package:gymnastic_center/application/clients/link-device/link_device_bloc.dart';
import 'package:gymnastic_center/application/comments/bloc/comments_bloc.dart';
import 'package:gymnastic_center/application/courses/course-details/course_details_bloc.dart';
import 'package:gymnastic_center/application/courses/all-courses/courses_bloc.dart';
import 'package:gymnastic_center/application/courses/delete-course/delete_course_bloc.dart';
import 'package:gymnastic_center/application/courses/delete-lesson/delete_lesson_bloc.dart';
import 'package:gymnastic_center/application/courses/lessons/bloc/lessons_bloc.dart';
import 'package:gymnastic_center/application/notifications/bloc/notifications_bloc.dart';
import 'package:gymnastic_center/application/notifications/notification-list/notification_list_bloc.dart';
import 'package:gymnastic_center/application/profile/profile_bloc.dart';
import 'package:gymnastic_center/application/search/bloc/search_bloc.dart';
import 'package:gymnastic_center/application/search/tags/tags_bloc.dart';
import 'package:gymnastic_center/application/suscriptions/course-progress/course_progress_bloc.dart';
import 'package:gymnastic_center/application/suscriptions/suscribed-courses/suscribed_courses_bloc.dart';
import 'package:gymnastic_center/application/suscriptions/suscription/suscription_bloc.dart';
import 'package:gymnastic_center/application/suscriptions/trending-progress/trending_progress_bloc.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';
import 'package:gymnastic_center/application/trainers/bloc/trainers_bloc.dart';
import 'package:gymnastic_center/application/trainers/delete-trainer/delete_trainer_bloc.dart';
import 'package:gymnastic_center/application/trainers/follow-trainer/follow_trainer_bloc.dart';
import 'package:gymnastic_center/application/trainers/trainer-details/trainer_details_bloc.dart';
import 'package:gymnastic_center/application/video_player/bloc/video_player_bloc.dart';
import 'package:gymnastic_center/infrastructure/datasources/blogs/api_blog_datasource.dart';
import 'package:gymnastic_center/infrastructure/datasources/categories/categories_datasource_impl.dart';
import 'package:gymnastic_center/infrastructure/datasources/client/clients_datasource_impl.dart';
import 'package:gymnastic_center/infrastructure/datasources/comments/api_comment_datasource.dart';
import 'package:gymnastic_center/infrastructure/datasources/courses/api_courses_datasource.dart';
import 'package:gymnastic_center/infrastructure/datasources/notifications/notifications_datasource_impl.dart';
import 'package:gymnastic_center/infrastructure/datasources/search/api_search_datasource.dart';
import 'package:gymnastic_center/infrastructure/datasources/suscriptions/api_suscription_datasource.dart';
import 'package:gymnastic_center/infrastructure/datasources/trainers/api_trainer_datasource.dart';
import 'package:gymnastic_center/infrastructure/datasources/user/api_user_datasource.dart';
import 'package:gymnastic_center/infrastructure/firebase/firebase_notifications_manager.dart';
import 'package:gymnastic_center/infrastructure/local_notifications/local_notifications.dart';
import 'package:gymnastic_center/infrastructure/local_storage/local_storage.dart';
import 'package:gymnastic_center/infrastructure/repositories/blogs/blog_repository_impl.dart';
import 'package:gymnastic_center/infrastructure/repositories/categories/categories_repository_impl.dart';
import 'package:gymnastic_center/infrastructure/repositories/clients/clients_repository_impl.dart';
import 'package:gymnastic_center/infrastructure/repositories/comments/comments_repository_impl.dart';
import 'package:gymnastic_center/infrastructure/repositories/courses/courses_repository_impl.dart';
import 'package:gymnastic_center/infrastructure/repositories/notifications/notifications_repository_impl.dart';
import 'package:gymnastic_center/infrastructure/repositories/search/search_repository_impl.dart';
import 'package:gymnastic_center/infrastructure/repositories/suscriptions/suscription_repository_impl.dart';
import 'package:gymnastic_center/infrastructure/repositories/trainers/trainers_repository_impl.dart';
import 'package:gymnastic_center/infrastructure/repositories/user/user_repository_impl.dart';

final getIt = GetIt.instance;

class Injector {
  void setUp() {
    final LocalStorageService localStorageService = LocalStorageService();

    final apiBlogDatasource = APIBlogDatasource(localStorageService);
    final apiCoursesDatasource = ApiCoursesDatasource(localStorageService);
    final apiUserDatasource = APIUserDatasource();
    final clientsDatasourceImpl = ClientsDatasourceImpl(localStorageService);
    final apiSuscriptionDatasource =
        APISuscriptionDatasource(localStorageService);
    final apiTrainersDatasource = ApiTrainersDatasource(localStorageService);
    final apiSearchDatasource = ApiSearchDatasource(localStorageService);
    final apiCommentDatasource = ApiCommentDatasource(localStorageService);
    final apiCategoriesDatasource =
        CategoriesDatasourceImpl(localStorageService);

    final blogRepositoryImpl =
        BlogRepositoryImpl(blogsDatasource: apiBlogDatasource);
    final coursesRepositoryImpl = CoursesRepositoryImpl(apiCoursesDatasource);
    final suscriptionRepositoryImpl =
        SuscriptionRepositoryImpl(apiSuscriptionDatasource);
    final userRepositoryImpl = UserRepositoryImpl(
        userDatasource: apiUserDatasource,
        keyValueStorage: localStorageService);
    final clientsRepositoryImpl = ClientsRepositoryImpl(
        clientsDatasource: clientsDatasourceImpl,
        keyValueStorage: localStorageService);
    final notificationsRepositoryImpl = NotificationRespositoryImpl(
        notificationsDatasource:
            NotificationsDatasourceImpl(localStorageService));
    final trainersRepositoryImpl =
        TrainersRepositoryImpl(apiTrainersDatasource);
    final searchRepositoryImpl = SearchRepositoryImpl(apiSearchDatasource);
    final categoriesRepositoryImpl =
        CategoriesRespositoryImpl(categoryDatasource: apiCategoriesDatasource);
    final commentsRepositoryImpl =
        CommentsRepositoryImpl(commentsDatasource: apiCommentDatasource);

    getIt.registerFactory(() => CommentsBloc(commentsRepositoryImpl));
    getIt.registerFactory(() => BlogsBloc(blogRepositoryImpl));
    getIt.registerFactory(
      () => BlogDetailsBloc(blogRepositoryImpl),
    );
    getIt.registerFactory(
        () => CoursesBloc(coursesRepository: coursesRepositoryImpl));
    getIt.registerFactory(
      () => CourseDetailsBloc(coursesRepositoryImpl),
    );
    getIt.registerFactory(() => SuscriptionBloc(suscriptionRepositoryImpl));
    getIt
        .registerFactory(() => SuscribedCoursesBloc(suscriptionRepositoryImpl));
    getIt
        .registerFactory(() => TrendingProgressBloc(suscriptionRepositoryImpl));
    getIt.registerFactory(
      () => CategoriesBloc(categoryRepository: categoriesRepositoryImpl),
    );
    getIt.registerFactory(() => RegisterBloc(userRepositoryImpl.register));
    getIt.registerFactory(() => LoginBloc(userRespository: userRepositoryImpl));
    getIt.registerFactory(() => VideoPlayerBloc());
    getIt.registerFactory(() => UpdateBloc(clientsRepositoryImpl));
    getIt.registerFactory(() => NotificationListBloc(
        notificationsRepository: notificationsRepositoryImpl));
    getIt.registerSingleton(ThemesBloc());
    getIt.registerSingleton(NotificationsBloc(
        FirebaseNotificationsManager(LocalNotifications()),
        notificationsRepositoryImpl.saveToken));
    getIt.registerSingleton(ClientsBloc(clientsRepositoryImpl));
    getIt.registerSingleton(
        RecoverPasswordBloc(userRespository: userRepositoryImpl));
    getIt.registerFactory(
      () => TrainerDetailsBloc(trainersRepositoryImpl),
    );
    getIt.registerLazySingleton(
        () => LessonsBloc(coursesRepository: coursesRepositoryImpl));
    getIt.registerFactory(() => SearchBloc(searchRepositoryImpl));
    getIt.registerLazySingleton(
        () => CourseProgressBloc(suscriptionRepositoryImpl));

    getIt.registerFactory(() => TagsBloc(searchRepositoryImpl));

    getIt.registerFactory(() => TrainersBloc(trainersRepositoryImpl));

    getIt.registerFactory(() => FollowTrainerBloc(trainersRepositoryImpl));

    getIt.registerFactory(() => LinkDeviceBloc(clientsRepositoryImpl));

    getIt.registerFactory(() => DeleteBlogBloc(blogRepositoryImpl));

    getIt.registerFactory(() => DeleteCourseBloc(coursesRepositoryImpl));

    getIt.registerFactory(() => DeleteTrainerBloc(trainersRepositoryImpl));

    getIt.registerFactory(() => ProfileBloc(
        suscriptionRepository: suscriptionRepositoryImpl,
        trainersRepository: trainersRepositoryImpl));

    getIt.registerFactory(() => DeleteLessonBloc(coursesRepositoryImpl));

  }
}