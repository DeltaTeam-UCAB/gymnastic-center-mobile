import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/courses/all-courses/courses_bloc.dart';
import 'package:gymnastic_center/application/courses/delete-course/delete_course_bloc.dart';
import 'package:gymnastic_center/domain/datasources/courses/course_datasource.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/presentation/screens/admin/widgets/slide_admin.dart';

class CoursesAdminView extends StatefulWidget {
  const CoursesAdminView({super.key});

  @override
  State<CoursesAdminView> createState() => _CoursesAdminViewState();
}

class _CoursesAdminViewState extends State<CoursesAdminView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (context.read<CoursesBloc>().state.courses.isNotEmpty) {
      context.read<CoursesBloc>().refreshCourses();
    }

    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        context.read<CoursesBloc>().loadNextPage(filter: CourseFilter.recent);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final void Function() refresh = context.watch<CoursesBloc>().refreshCourses;

    return BlocListener<DeleteCourseBloc, DeleteCourseState>(
      listener: (context, state) {
        if (state.status == DeleteCourseStatus.deleted) {
          refresh();
        }
      },
      child: BlocBuilder<CoursesBloc, CoursesState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.isError) {
            return const Center(
              child: Text('Error'),
            );
          }

          if (state.courses.isEmpty) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElasticIn(
                  child: SvgPicture.asset(
                    'assets/search/not-found-2.svg',
                    width: 450,
                  ),
                ),
                const SizedBox(height: 10),
                const Text('No blogs found. Ups!',
                    style: TextStyle(fontSize: 20)),
              ],
            ));
          }

          return CustomGridView(
              scrollController: _scrollController, courses: state.courses);
        },
      ),
    );
  }
}

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    super.key,
    required ScrollController scrollController,
    required this.courses,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final List<Course> courses;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return GestureDetector(
          onTap: () => context.push('/admin/1/courses/${course.id}'),
          child: SlideAdmin(
            id: course.id,
            image: course.image,
            onPressed: context.read<DeleteCourseBloc>().deleteCourse,
            title: course.title,
            trainer: course.trainer.name,
            type: 'Course',
          ),
        );
      },
    );
  }
}
