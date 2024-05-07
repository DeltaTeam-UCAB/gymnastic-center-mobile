import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/shared/custom_appbar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          automaticallyImplyLeading: false,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
            centerTitle: false,
            titlePadding: EdgeInsets.symmetric(),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return const Column(
            children: [
              // TODO: Add the widgets here.
              Placeholder(),
              Placeholder(),
            ],
          );
        }, childCount: 1))
      ],
    );
  }
}
