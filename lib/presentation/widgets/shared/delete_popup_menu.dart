import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeletePopupMenu extends StatelessWidget {
  final void Function() onPressed;
  final Color color;
  final String dialogTitle;
  final String dialogBody;
  final String dialogAccept;
  final String dialogDeny;
  final String popuplabel;


  const DeletePopupMenu({
    super.key,
    required this.onPressed,
    required this.color,
    required this.dialogTitle,
    required this.dialogBody,
    required this.dialogAccept,
    required this.dialogDeny,
    required this.popuplabel

  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) {
        showDialog(
          context: context,
          builder: (context) 
            =>   AlertDialog(
                title: Text(dialogTitle),
                content: Text(dialogBody),
                actions: [
                  TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: Text(dialogDeny)
                  ),
                  TextButton(
                    onPressed: () {
                      onPressed();
                      context.pop();
                    },
                    child: Text(dialogAccept)
                  ),
                ],
          ),
        );
      },
      iconColor: color,
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: popuplabel,
            child: ListTile(
              leading: const Icon(Icons.delete_outline_outlined),
              iconColor: Colors.redAccent,
              title: Text(popuplabel),
            ),
          )
        ];
      },
    );
  }
}
