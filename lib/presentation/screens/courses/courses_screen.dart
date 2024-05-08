import 'package:flutter/material.dart';
import 'package:gymnastic_center/domain/entities/courses/course.dart';
import 'package:gymnastic_center/presentation/widgets/courses/course_slide.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/courses/courses_bloc.dart';
import 'package:gymnastic_center/infrastructure/datasources/courses/courses_datasource_impl.dart';
import 'package:gymnastic_center/infrastructure/repositories/courses/courses_repository_impl.dart';


class AllCoursesScreen extends StatelessWidget {  
  const AllCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CoursesBloc(
          coursesRepository: CoursesRepositoryImpl(CoursesDatasourceImpl())),       
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

  
  final List<Course> courses = [
    Course(
        id: '1',
        title: 'Tadasana Yoga',
        category: 'Yoga',
        released: DateTime.utc(2024, 5, 4),
        image:
            'https://images.ecestaticos.com/gnBzw92jLNdX0ELHqXqKtdX71fM=/152x0:2173x1516/557x418/filters:fill(white):format(jpg)/f.elconfidencial.com%2Foriginal%2Ffde%2F466%2Ff01%2Ffde466f01483ddb15a4d6d9d9cdd97ad.jpg',
        description: 'aaaaaaa',
        calories: 'aaaaa',
        instructor: 'aaaaaa',
        lessons: []),
    Course(
        id: '2',
        title: 'Marvin McKinney',
        category: 'Yoga',
        released: DateTime.utc(2024, 5, 4),
        image:
            'https://www.health.com/thmb/jZUEZBuA4eO7WBWURoOCkxdLGFU=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/GettyImages-1395504255-33d159af773f45039286966a35dfd76d.jpg',
        description: 'aaaaaaa',
        calories: 'aaaaa',
        instructor: 'aaaaaa',
        lessons: []),
    Course(
        id: '3',
        title: 'Abs core',
        category: 'Train',
        released: DateTime.utc(2024, 1, 1),
        image:
            'https://cdn-lagkd.nitrocdn.com/HaBlunxQzwoNVRZDCOMTzKlXBzanMpLU/assets/images/optimized/rev-b4f9958/www.aestheticsmedispa.in/wp-content/uploads/2023/09/Six-Pack-Abs-via-VASER-No-Exercise-Needed-1536x865.jpg',
        description: 'aaaaaaa',
        calories: 'aaaaa',
        instructor: 'aaaaaa',
        lessons: [])
        
  ];

final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    context.read<CoursesBloc>().loadNextPage();
    super.initState();
    // Hara algo
    
    _scrollController.addListener(() {
      if ( _scrollController.position.pixels + 400 >= _scrollController.position.maxScrollExtent){
        context.read<CoursesBloc>().loadNextPage();
        // Hara algo
      }
      final courses = context.watch<CoursesBloc>().state.courses;
    });
    
  }
  

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  



  @override
  Widget build(BuildContext context) {
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
