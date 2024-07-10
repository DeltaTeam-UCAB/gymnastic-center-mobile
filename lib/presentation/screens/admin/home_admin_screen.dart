import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lazy_indexed_stack/flutter_lazy_indexed_stack.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/blogs/bloc/blogs_bloc.dart';
import 'package:gymnastic_center/application/blogs/delete-blog/delete_blog_bloc.dart';
import 'package:gymnastic_center/application/clients/bloc/clients_bloc.dart';
import 'package:gymnastic_center/application/courses/courses_bloc.dart';
import 'package:gymnastic_center/application/courses/delete-course/delete_course_bloc.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';
import 'package:gymnastic_center/application/trainers/bloc/trainers_bloc.dart';
import 'package:gymnastic_center/application/trainers/delete-trainer/delete_trainer_bloc.dart';
import 'package:gymnastic_center/infrastructure/local_storage/local_storage.dart';
import 'package:gymnastic_center/injector.dart';
import 'package:gymnastic_center/presentation/screens/admin/views/blogs_view.dart';
import 'package:gymnastic_center/presentation/screens/admin/views/courses_view.dart';
import 'package:gymnastic_center/presentation/screens/admin/views/trainers_view.dart';
import 'package:gymnastic_center/presentation/screens/admin/widgets/admin_bottom_navigation_bar.dart';

class HomeAdminScreen extends StatelessWidget {
  final int pageIndex;
  const HomeAdminScreen({super.key, required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<BlogsBloc>()..loadNextPage()),
        BlocProvider(create: (_) => getIt<CoursesBloc>()..loadNextPage()),
        BlocProvider(create: (_) => getIt<TrainersBloc>()..loadNextPage()),
        BlocProvider(create: (_) => getIt<DeleteBlogBloc>()),
        BlocProvider(create: (_) => getIt<DeleteCourseBloc>()),
        BlocProvider(create: (_) => getIt<DeleteTrainerBloc>()),
      ],
      child: HomeAdminView(pageIndex: pageIndex),
    );
  }
}

class HomeAdminView extends StatefulWidget {
  final int pageIndex;
  const HomeAdminView({super.key, required this.pageIndex});

  @override
  State<HomeAdminView> createState() => _HomeAdminViewState();
}

class _HomeAdminViewState extends State<HomeAdminView> {
  @override
  void initState() {
    context.read<ClientsBloc>().getClientData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
          titleSpacing: 0,
          title: Text(
              'Admin Panel / ${widget.pageIndex == 0 ? 'Blogs' : widget.pageIndex == 1 ? 'Courses' : 'Trainers'}'),
          leading: IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () {
              LocalStorageService()
                ..removeKey('token')
                ..removeKey('isAdmin').then((value) => context.go('/start'));
            },
          ),
          actions: const <Widget>[
            _ThemeMode(),
            SizedBox(
              width: 20,
            )
          ]),
      body: LazyIndexedStack(
        index: widget.pageIndex,
        children: <Widget>[
          FadeIn(child: const BlogsAdminView()),
          FadeIn(child: const CoursesAdminView()),
          FadeIn(child: const TrainersAdminView()),
        ],
      ),
      bottomNavigationBar:
          AdminBottomNavigationBar(currentIndex: widget.pageIndex),
    );
  }
}

class _ThemeMode extends StatelessWidget {
  const _ThemeMode();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemesBloc>().isDarkMode;
    return IconButton(
      icon: isDarkMode
          ? const Icon(Icons.light_mode_outlined)
          : const Icon(Icons.dark_mode_outlined),
      onPressed: context.watch<ThemesBloc>().changeTheme,
    );
  }
}
