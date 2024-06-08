import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/courses/courses_bloc.dart';
import 'package:gymnastic_center/infrastructure/datasources/courses/api_courses_datasource.dart';
import 'package:gymnastic_center/infrastructure/local_storage/local_storage.dart';
import 'package:gymnastic_center/infrastructure/repositories/courses/courses_repository_impl.dart';
import 'package:gymnastic_center/presentation/widgets/courses/course_slide.dart';

class AllCoursesScreen extends StatelessWidget {
  const AllCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CoursesBloc(
          coursesRepository: CoursesRepositoryImpl(
              ApiCoursesDatasource(LocalStorageService()))),
      child: const _AllCoursesScreen(),
    );
  }
}

class _AllCoursesScreen extends StatefulWidget {
  const _AllCoursesScreen({Key? key}) : super(key: key);

  @override
  _AllCoursesScreenState createState() => _AllCoursesScreenState();
}

class _AllCoursesScreenState extends State<_AllCoursesScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    context.read<CoursesBloc>().loadNextPage();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels + 400 >=
          _scrollController.position.maxScrollExtent) {
        context.read<CoursesBloc>().loadNextPage();
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
    final courses = context.watch<CoursesBloc>().state.courses;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Courses',
          style: TextStyle(color: Colors.white, fontFamily: 'PT Sans'),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 27),
                child: Text('Sort by: '),
              ),
              TextButton.icon(
                  onPressed: () {
                    // Add your sorting logic here
                  },
                  icon: const Icon(Icons.arrow_drop_down_outlined),
                  label: const Text('newest'))
            ],
          ),
          Expanded(
            child: GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                return CourseSlide(course: courses[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
