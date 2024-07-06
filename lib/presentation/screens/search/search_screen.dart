import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/search/search_bloc.dart';
import 'package:gymnastic_center/application/search/tags/tags_bloc.dart';
import 'package:gymnastic_center/infrastructure/datasources/search/api_search_datasource.dart';
import 'package:gymnastic_center/infrastructure/local_storage/local_storage.dart';
import 'package:gymnastic_center/infrastructure/repositories/search/search_repository_impl.dart';
import 'package:gymnastic_center/presentation/screens/search/widgets/search_bar.dart';
import 'package:gymnastic_center/presentation/screens/search/widgets/search_tab_blogs.dart';
import 'package:gymnastic_center/presentation/screens/search/widgets/search_tab_courses.dart';
import 'package:gymnastic_center/presentation/screens/search/widgets/search_tags.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SearchBloc(
              SearchRepositoryImpl(ApiSearchDatasource(LocalStorageService()))),
        ),
        BlocProvider(
          create: (_) => TagsBloc(
              SearchRepositoryImpl(ApiSearchDatasource(LocalStorageService())))
            ..loadPopularTags(),
        )
      ],
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatelessWidget {
  const _SearchView();
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _SearchForm(),
    );
  }
}

class _SearchForm extends StatelessWidget {
  const _SearchForm();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(top: 0, left: 0, right: 0, child: _customAppBar(context)),
        Positioned(
          top: 100,
          left: 0,
          right: 0,
          child: SearchInput(
              search: context.read<SearchBloc>().search,
              onClear: context.read<SearchBloc>().resetSearch),
        ),
        Positioned(
          top: 165,
          left: 0,
          right: 0,
          bottom: 0,
          child: BlocBuilder<TagsBloc, TagsState>(
            builder: (context, state) {
              if (state.status == TagStatus.loading) {
                return const Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text('Loading Tags...'),
                  ],
                ));
              }
              return _SearchBody(state.tags);
            },
          ),
        )
      ],
    );
  }
}

Widget _customAppBar(BuildContext context) {
  return SizedBox(
    height: kToolbarHeight * 2.35,
    child: AppBar(
      title:
          const Text('Popular Search', style: TextStyle(color: Colors.white)),
      leading: IconButton(
          onPressed: context.pop, icon: const Icon(Icons.arrow_back_ios_new)),
    ),
  );
}

class _SearchBody extends StatefulWidget {
  final List<String> tags;
  const _SearchBody(this.tags);

  @override
  State<_SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<_SearchBody>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchTags(widget.tags,
            onChangeTags: context.read<SearchBloc>().onChangeTags),
        TabBar(controller: _tabController, tabs: const [
          Tab(
            text: 'Courses',
          ),
          Tab(
            text: 'Blogs',
          ),
        ]),
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state.status == SearchStatus.initial) {
                return TabBarView(
                  controller: _tabController,
                  children: const [
                    Center(child: Text('Busca Información')),
                    Center(child: Text('Busca Informacion')),
                  ],
                );
              }

              if (state.status == SearchStatus.loading &&
                  state.courses.isEmpty &&
                  state.blogs.isEmpty) {
                return TabBarView(
                  controller: _tabController,
                  children: const [
                    Center(child: CircularProgressIndicator()),
                    Center(child: CircularProgressIndicator()),
                  ],
                );
              }

              return TabBarView(
                controller: _tabController,
                children: [
                  SearchTabCourses(
                      popularCourse: state.courses.take(3).toList(),
                      restCourse: state.courses.skip(3).toList(),
                      loadNextPage: context.read<SearchBloc>().loadNextPage,
                      loading: state.status == SearchStatus.loading),
                  SearchTabBlogs(
                      popularBlogs: state.blogs.take(3).toList(),
                      restBlogs: state.blogs.skip(3).toList(),
                      loadNextPage: context.read<SearchBloc>().loadNextPage,
                      loading: state.status == SearchStatus.loading),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
