import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/courses/course-details/course_details_bloc.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/infrastructure/datasources/courses/api_courses_datasource.dart';
import 'package:gymnastic_center/infrastructure/local_storage/local_storage.dart';
import 'package:gymnastic_center/infrastructure/repositories/courses/courses_repository_impl.dart';
import 'package:gymnastic_center/presentation/screens/courses/widgets/course_details_view.dart';
import 'package:gymnastic_center/presentation/widgets/shared/navigation_bar/custom_bottom_navigation.dart';

class CourseScreen extends StatelessWidget {
  final String courseId;
  const CourseScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CourseDetailsBloc(
          CoursesRepositoryImpl(ApiCoursesDatasource(LocalStorageService())))
        ..getCourseById(courseId),
      child: const _CourseScreenView(),
    );
  }
}

class _CourseScreenView extends StatelessWidget {
  const _CourseScreenView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseDetailsBloc, CourseDetailsState>(
      buildWhen: (previous, current) => (previous.course != current.course),
      builder: (context, state) {
        return Scaffold(
          body: state.status != CourseDetailsStatus.loading && state.status != CourseDetailsStatus.initial
              ? _Details(course: state.course)
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          bottomNavigationBar: const CustomBottomNavigation(currentIndex: 0),
        );
      },
    );
  }
}

class _Details extends StatelessWidget {
  final Course course;

  const _Details({
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: CourseDetailsView(course: course),
        ),
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              titleSpacing: -10,
              title: const Text('Course Details',
                  style: TextStyle(color: Colors.white)),
              elevation: 0,
            )),
      ],
    );
  }
}
