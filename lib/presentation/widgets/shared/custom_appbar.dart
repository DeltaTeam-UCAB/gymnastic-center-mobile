import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Raytory Roxty',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),

        // Avatar
        Row(
          children: [
            if (isExpanded)
              FadeIn(
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                  iconSize: 30,
                )
              ),
            const SizedBox(width: 5,),
            const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://secrecyjewels.es/blog/wp-content/uploads/2022/10/esencia-de-una-persona.jpg"),
              backgroundColor: Colors.deepPurple,
              radius: 25,
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
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Search'),
          Icon(Icons.search),
        ],
      ),
    );
  }
}