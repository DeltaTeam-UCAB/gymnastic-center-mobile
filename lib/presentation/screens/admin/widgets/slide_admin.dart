import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/shared/delete_popup_menu.dart';

class SlideAdmin extends StatelessWidget {
  final String id;
  final String title;
  final String trainer;
  final String image;
  final String type;
  final Function(String id) onPressed;

  const SlideAdmin(
      {super.key,
      required this.id,
      required this.title,
      required this.image,
      required this.onPressed,
      required this.trainer,
      required this.type});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Image.network(
              image,
              height: 400,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return FadeIn(child: child);
              },
            ),
          ),
        ),

        // Gradiente
        Container(
          height: 400,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.black87
                    .withOpacity(0.2), 
                Colors.black87,
              ],
              stops: const [0.0, 0.6, 1.0],
            ),
          ),
        ),

        // Title
        Positioned(
          bottom: 10,
          left: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                trainer,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: colors.inversePrimary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),

        // Button on topRight
        Align(
          alignment: Alignment.topRight,
          child: DeletePopupMenu(
            onPressed: () => onPressed(id),
            color: Colors.white,
            dialogTitle: '$type deleted',
            dialogBody: 'Are you sure you want to delete this $type?',
            dialogAccept: 'Delete',
            dialogDeny: 'Cancel',
            popuplabel: 'Delete $type',
          ),
        ),
      ],
    );
  }
}
