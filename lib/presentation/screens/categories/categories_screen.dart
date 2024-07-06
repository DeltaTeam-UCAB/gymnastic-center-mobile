import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/categories/bloc/categories_bloc.dart';
import 'package:gymnastic_center/domain/entities/categories/category.dart';
import 'package:gymnastic_center/injector.dart';
import 'package:gymnastic_center/presentation/screens/categories/widgets/all_categories_slide.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CategoriesBloc>(),
      child: const _AllCategoriesScreen(),
    );
  }
}

class _AllCategoriesScreen extends StatefulWidget {
  const _AllCategoriesScreen({Key? key}) : super(key: key);

  @override
  _AllCategoriesScreenState createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<_AllCategoriesScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    context.read<CategoriesBloc>().loadNextPage();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels + 400 >=
          _scrollController.position.maxScrollExtent) {
        context.read<CategoriesBloc>().loadNextPage();
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
    final categories = context.watch<CategoriesBloc>().state.categories;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Categories',
          style: TextStyle(color: Colors.white, fontFamily: 'PT Sans'),
        ),
      ),
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          if (state.isLoading && state.categories.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.isError) {
            return const Center(child: Text('Error loading categories'));
          }

          return _CategoriesView(
            scrollController: _scrollController,
            categories: categories,
          );
        },
      ),
    );
  }
}

class _CategoriesView extends StatelessWidget {
  const _CategoriesView({
    required ScrollController scrollController,
    required this.categories,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.fromLTRB(22, 30, 10, 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return AllCategoriesSlide(category: categories[index]);
            },
          ),
        ),
      ],
    );
  }
}
