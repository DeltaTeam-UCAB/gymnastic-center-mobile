import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/trainers/bloc/trainers_bloc.dart';
import 'package:gymnastic_center/application/trainers/follow-trainer/follow_trainer_bloc.dart';
import 'package:gymnastic_center/domain/entities/trainers/trainer.dart';
import 'package:gymnastic_center/injector.dart';
import 'package:gymnastic_center/presentation/widgets/shared/navigation_bar/custom_bottom_navigation.dart';

class TrainersScreen extends StatelessWidget {
  const TrainersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<TrainersBloc>()..loadNextPage(),
        ),
        BlocProvider(
          create: (context) => getIt<FollowTrainerBloc>(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Trainers',
              style: TextStyle(
                color: Colors.white,
              )),
        ),
        body: const _TrainersView(),
        bottomNavigationBar: const CustomBottomNavigation(
          currentIndex: 0,
        ),
      ),
    );
  }
}

class _TrainersView extends StatefulWidget {
  const _TrainersView();

  @override
  State<_TrainersView> createState() => _TrainersViewState();
}

class _TrainersViewState extends State<_TrainersView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        context.read<TrainersBloc>().loadNextPage();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainersBloc, TrainersState>(
      builder: (context, state) {
        if (state.status == TrainersStatus.loading && state.trainers.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == TrainersStatus.error) {
          return const Center(child: Text('Failed to load trainers'));
        }

        if (state.trainers.isEmpty) {
          return const Center(child: Text('No trainers found'));
        }

        return ListView.separated(
          controller: _scrollController,
          itemCount: state.trainers.length,
          itemBuilder: (context, index) => _TrainerSlide(
            trainer: state.trainers[index].trainer,
            isFollowing: state.trainers[index].isFollowing,
            toggleFollow: context.read<FollowTrainerBloc>().toggleFollow,
          ),
          separatorBuilder: (context, index) => const Divider(height: 2),
        );
      },
    );
  }
}

class _TrainerSlide extends StatefulWidget {
  final Trainer trainer;
  final bool isFollowing;
  final Future<bool> Function(String trainerId) toggleFollow;
  const _TrainerSlide(
      {required this.trainer,
      required this.isFollowing,
      required this.toggleFollow});

  @override
  State<_TrainerSlide> createState() => _TrainerSlideState();
}

class _TrainerSlideState extends State<_TrainerSlide> {
  bool _isFollowing = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isFollowing = widget.isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        title: Text(widget.trainer.name),
        subtitle: Text(widget.trainer.location),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(widget.trainer.image),
        ),
        trailing: ElevatedButton(
          onPressed: () async {
            final result = await widget.toggleFollow(widget.trainer.id);
            if (result) {
              setState(() {
                _isFollowing = !_isFollowing;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                _isFollowing ? colors.inversePrimary : Colors.white,
          ),
          child: Text(_isFollowing ? 'Following' : 'Follow',
              style: TextStyle(
                color: _isFollowing ? Colors.white : colors.inversePrimary,
                fontWeight: FontWeight.bold,
              )),
        ),
        onTap: () => context.push('/home/0/trainer/${widget.trainer.id}'),
      ),
    );
  }
}
