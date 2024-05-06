import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.sports_gymnastics),
              const SizedBox(width: 5),
              Text('Gymnastic Center', style: titleStyle),
              const Spacer(),
              IconButton(onPressed: (){}, icon: const Icon(Icons.search, color: Colors.white,))
            ],
          ),
        ),
      )
    );
  }
}

