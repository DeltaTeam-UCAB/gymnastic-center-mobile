import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/categories/bloc/categories_bloc.dart';
import 'package:gymnastic_center/application/courses/courses_bloc.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/injector.dart';
import 'package:gymnastic_center/presentation/widgets/courses/course_slide.dart';

class AllCoursesScreen extends StatelessWidget {
  final String? selectedCategoryId;

  const AllCoursesScreen({super.key, this.selectedCategoryId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<CoursesBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt<CategoriesBloc>(),
        ),
      ],
      child: _AllCoursesScreen(
        selectedCategoryId:
            selectedCategoryId == null ? '' : selectedCategoryId!,
      ),
    );
  }
}

class _AllCoursesScreen extends StatefulWidget {
  final String selectedCategoryId;
  const _AllCoursesScreen({Key? key, required this.selectedCategoryId})
      : super(key: key);

  @override
  _AllCoursesScreenState createState() => _AllCoursesScreenState();
}

class _AllCoursesScreenState extends State<_AllCoursesScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    if (widget.selectedCategoryId.isEmpty) {
      context.read<CoursesBloc>().loadNextPage();
    } else {
      context
          .read<CoursesBloc>()
          .loadNextPage(categoryId: widget.selectedCategoryId);
    }
    context.read<CategoriesBloc>().loadNextPage();

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
      body: BlocBuilder<CoursesBloc, CoursesState>(
        builder: (context, state) {
          if (state.isLoading && state.courses.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.isError) {
            return const Center(child: Text('Error loading courses'));
          }

          return Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              _CoursesView(
                  scrollController: _scrollController, courses: courses),
            ],
          );
        },
      ),
    );
  }
}

class _CoursesView extends StatelessWidget {
  const _CoursesView(
      {required ScrollController scrollController, required this.courses})
      : _scrollController = scrollController;

  final ScrollController _scrollController;
  final List<Course> courses;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }
}
