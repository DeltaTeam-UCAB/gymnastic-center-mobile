import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/clients/bloc/clients_bloc.dart';
import 'package:gymnastic_center/domain/entities/client/client.dart';
import 'package:gymnastic_center/presentation/widgets/shared/image_view.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final isExpanded = constraints.maxHeight < 160;
        return SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _AppBarTitle(isExpanded),
                  SizedBox(
                    width: double.infinity,
                    child: (!isExpanded)
                        ? FadeIn(child: const _SearchButton())
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  final bool isExpanded;
  const _AppBarTitle(this.isExpanded);

  @override
  Widget build(BuildContext context) {
    final Client client = context.watch<ClientsBloc>().state.client;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          client.name.length <= 18
              ? client.name
              : '${client.name.substring(0, 18)}...',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            color: Colors.white,
          ),
        ),

        // Avatar
        Row(
          children: [
            if (isExpanded)
              FadeIn(
                  child: IconButton(
                onPressed: () => context.push('/home/0/search'),
                icon: const Icon(Icons.search, color: Colors.white),
                iconSize: 30,
              )),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () => context.push('/account/details'),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 17,
                child: client.avatarImage == null
                    ? const Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.deepPurple,
                      )
                    : SizedBox(
                        height: 50,
                        width: 50,
                        child: ClipOval(
                            child: ImageView(image: client.avatarImage!))),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SearchButton extends StatelessWidget {
  const _SearchButton();

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => context.push('/home/0/search'),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Search'),
          IconButton(
            onPressed: () => context.push('/home/0/search'),
            icon: const Icon(Icons.search),
          )
        ],
      ),
    );
  }
}
