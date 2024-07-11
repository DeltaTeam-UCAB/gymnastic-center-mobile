import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/presentation/widgets/shared/no_content.dart';

class ComingSoonScreen extends StatelessWidget {
  final String title;
  const ComingSoonScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontFamily: 'PT Sans'),
        ),
      ),
      body: Column(
        children: [
          const NoContent(
            image: 'assets/exercising.svg',
            text: 'Coming soon...',
            heighFactor: 1.6,
          ),
          FilledButton(
              onPressed: () => context.push('/home/0'),
              child: const Text('Home'))
        ],
      ),
    );
  }
}
