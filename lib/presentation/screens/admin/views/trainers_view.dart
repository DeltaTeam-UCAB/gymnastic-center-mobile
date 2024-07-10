import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gymnastic_center/application/trainers/bloc/trainers_bloc.dart';
import 'package:gymnastic_center/application/trainers/delete-trainer/delete_trainer_bloc.dart';
import 'package:gymnastic_center/domain/entities/trainers/trainer.dart';
import 'package:gymnastic_center/presentation/widgets/shared/delete_popup_menu.dart';

class TrainersAdminView extends StatefulWidget {
  const TrainersAdminView({super.key});

  @override
  State<TrainersAdminView> createState() => _TrainersAdminViewState();
}

class _TrainersAdminViewState extends State<TrainersAdminView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        context.read<TrainersBloc>().loadNextPage();
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
    return BlocListener<DeleteTrainerBloc, DeleteTrainerState>(
      listener: (context, state) {
        if (state.status == DeleteTrainerStatus.deleted) {
          context.read<TrainersBloc>().refreshTrainers();
        }
      },
      child: BlocBuilder<TrainersBloc, TrainersState>(
        builder: (context, state) {
          if (state.status == TrainersStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.trainers.isEmpty) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElasticIn(
                  child: SvgPicture.asset(
                    'assets/search/search-person.svg',
                    width: 450,
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Hey I think we dont have more trainer',
                    style: TextStyle(fontSize: 20)),
              ],
            ));
          }

          return ListView.separated(
            itemCount: state.trainers.length,
            itemBuilder: (context, index) => _TrainerSlide(
              trainer: state.trainers[index].trainer,
              onDelete: context.read<DeleteTrainerBloc>().deleteTrainer,
            ),
            separatorBuilder: (context, index) => const Divider(height: 2),
          );
        },
      ),
    );
  }
}

class _TrainerSlide extends StatelessWidget {
  final Trainer trainer;
  final Future<void> Function(String trainerId) onDelete;

  const _TrainerSlide({required this.trainer, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        title: Text(trainer.name),
        subtitle: Text(trainer.location),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(trainer.image),
        ),
        trailing: DeletePopupMenu(
          onPressed: () => onDelete(trainer.id),
          color: Colors.deepPurple,
          dialogTitle: 'Trainer deleted',
          dialogBody: 'Are you sure you want to delete this trainer?',
          dialogAccept: 'Delete',
          dialogDeny: 'Cancel',
          popuplabel: 'Delete trainer',
        ),
      ),
    );
  }
}
