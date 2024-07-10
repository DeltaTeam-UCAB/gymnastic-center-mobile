import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/notifications/notification-list/notification_list_bloc.dart';
import 'package:gymnastic_center/injector.dart';
import 'package:gymnastic_center/presentation/screens/notifications/widgets/notifications_listview.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NotificationListBloc>(),
      child: const Scaffold(
        appBar: _CustomAppBar(),
        body: NotificationsListView(),
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomAppBar();
  @override
  Widget build(BuildContext context) {
    var inbox =
        context.watch<NotificationListBloc>().state.notifications.length;
    return AppBar(
      title: Row(
        children: [
          const Text('Notifications'),
          const Spacer(),
          Text(
            '$inbox Inbox',
            style: const TextStyle(fontSize: 15),
          ),
          IconButton(
              onPressed:
                  context.read<NotificationListBloc>().deleteAllNotifications,
              icon: const Icon(Icons.delete_outline_rounded)),
          const SizedBox(width: 10)
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
