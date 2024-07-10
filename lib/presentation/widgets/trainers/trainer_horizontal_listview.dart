import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/domain/datasources/trainers/trainers_datasource.dart';
import 'package:gymnastic_center/domain/entities/trainers/trainer.dart';
import 'package:gymnastic_center/presentation/widgets/shared/see_all_button.dart';

class TrainerHorizontalListView extends StatelessWidget {
  final List<TrainerDetails> trainers;
  final String title;
  final String routeToGo;

  const TrainerHorizontalListView(
      {super.key,
      required this.trainers,
      required this.title,
      required this.routeToGo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 0),
      height: 240,
      child: Column(
        children: [
          _Title(
            title: title,
            routeToGo: routeToGo,
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: trainers.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final trainer = trainers[index].trainer;
                return GestureDetector(
                    onTap: () => context.push('/home/0/trainer/${trainer.id}'),
                    child: _TrainerSlide(trainer: trainer));
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String title;
  final String routeToGo;
  const _Title({required this.title, required this.routeToGo});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.headlineSmall;

    return Container(
      padding: const EdgeInsets.only(top: 0),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          const Spacer(),
          SeeAllButton(route: routeToGo),
        ],
      ),
    );
  }
}

class _TrainerSlide extends StatelessWidget {
  const _TrainerSlide({
    required this.trainer,
  });

  final Trainer trainer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: 150,
      child: Stack(children: [
        Positioned.fill(
          child: FadeInRight(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: trainer.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black87],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trainer.name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  trainer.location,
                  style: TextStyle(
                      color: Colors.deepPurple.shade200,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
