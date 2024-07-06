
import 'package:get_it/get_it.dart';
import 'package:gymnastic_center/application/auth/login/login_bloc.dart';
import 'package:gymnastic_center/application/auth/recover_password/recover_password_bloc.dart';
import 'package:gymnastic_center/application/auth/register/register_bloc.dart';
import 'package:gymnastic_center/application/auth/update/update_bloc.dart';
import 'package:gymnastic_center/application/blogs/bloc/blogs_bloc.dart';
import 'package:gymnastic_center/application/blogs/blog-details/blog_details_bloc.dart';
import 'package:gymnastic_center/application/categories/bloc/categories_bloc.dart';
import 'package:gymnastic_center/application/clients/bloc/clients_bloc.dart';
import 'package:gymnastic_center/application/comments/bloc/comments_bloc.dart';
import 'package:gymnastic_center/application/courses/course-details/course_details_bloc.dart';
import 'package:gymnastic_center/application/courses/courses_bloc.dart';
import 'package:gymnastic_center/application/courses/lessons/bloc/lessons_bloc.dart';
import 'package:gymnastic_center/application/notifications/bloc/notifications_bloc.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';
import 'package:gymnastic_center/application/trainers/trainer_bloc.dart';
import 'package:gymnastic_center/application/video_player/bloc/video_player_bloc.dart';
import 'package:gymnastic_center/infrastructure/datasources/blogs/api_blog_datasource.dart';
import 'package:gymnastic_center/infrastructure/datasources/categories/categories_datasource_impl.dart';
import 'package:gymnastic_center/infrastructure/datasources/client/clients_datasource_impl.dart';
import 'package:gymnastic_center/infrastructure/datasources/comments/api_comment_datasource.dart';
import 'package:gymnastic_center/infrastructure/datasources/courses/api_courses_datasource.dart';
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
import 'package:gymnastic_center/infrastructure/repositories/trainers/trainers_repository_impl.dart';
import 'package:gymnastic_center/infrastructure/repositories/user/user_repository_impl.dart';


final getIt = GetIt.instance;

class Injector{

  void setUp(){
    
    final LocalStorageService localStorageService = LocalStorageService();

    final apiBlogDatasource = APIBlogDatasource(localStorageService);
    final apiCoursesDatasource = ApiCoursesDatasource(localStorageService);
    final apiUserDatasource = APIUserDatasource();
    final clientsDatasourceImpl = ClientsDatasourceImpl(localStorageService);

    final blogRepositoryImpl = BlogRepositoryImpl(blogsDatasource: apiBlogDatasource);
    final coursesRepositoryImpl = CoursesRepositoryImpl(apiCoursesDatasource);
    final userRepositoryImpl = UserRepositoryImpl(userDatasource: apiUserDatasource,keyValueStorage: localStorageService);
    final clientsRepositoryImpl = ClientsRepositoryImpl(clientsDatasource: clientsDatasourceImpl, keyValueStorage: localStorageService);

    getIt.registerFactory(
      () => CommentsBloc(CommentsRepositoryImpl(
              commentsDatasource: ApiCommentDatasource(localStorageService))),
    );
    getIt.registerFactory(
      () => BlogsBloc(blogRepositoryImpl)
    );
    getIt.registerFactory(
      () => BlogDetailsBloc(blogRepositoryImpl),
    );
    getIt.registerFactory(
      () => CoursesBloc(coursesRepository: coursesRepositoryImpl)
    );
    getIt.registerFactory(
      () => CourseDetailsBloc(coursesRepositoryImpl),
    );
    getIt.registerFactory(
      () => CategoriesBloc(
            categoryRepository: CategoriesRespositoryImpl(
              categoryDatasource:
                  CategoriesDatasourceImpl(localStorageService))),
    );
    getIt.registerFactory(
      () => RegisterBloc(userRepositoryImpl.register)
    );
    getIt.registerFactory(
      () => LoginBloc(userRespository: userRepositoryImpl)
    );
    getIt.registerFactory(
      () => VideoPlayerBloc()
    );
    getIt.registerFactory(
      () => UpdateBloc(clientsRepositoryImpl)
    );
    getIt.registerSingleton(
      ThemesBloc()
    );
    getIt.registerSingleton(
      NotificationsBloc(
            FirebaseNotificationsManager(LocalNotifications()))
    );
    getIt.registerSingleton(
      ClientsBloc(clientsRepositoryImpl)
    );
    getIt.registerSingleton(
      RecoverPasswordBloc(userRespository: userRepositoryImpl)
    );
    getIt.registerSingleton(
      TrainerBloc(
        TrainersRepositoryImpl(
          ApiTrainersDatasource(localStorageService),
        ),
      ),
    );
    getIt.registerLazySingleton(
      () => LessonsBloc(coursesRepository: coursesRepositoryImpl)
    );
  }


}