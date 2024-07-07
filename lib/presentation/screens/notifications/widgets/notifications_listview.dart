import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/notifications/notification_list_bloc.dart';
import 'package:gymnastic_center/domain/entities/notifications/notification.dart'
    as entity;

class NotificationsListView extends StatefulWidget {
  const NotificationsListView({super.key});
  @override
  State<NotificationsListView> createState() => _NotificationsListViewState();
}

class _NotificationsListViewState extends State<NotificationsListView> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    context.read<NotificationListBloc>().loadNextPage();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels + 400 >=
          _scrollController.position.maxScrollExtent) {
        context.read<NotificationListBloc>().loadNextPage();
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
    final notifications =
        context.watch<NotificationListBloc>().state.notifications;
    final colors = Theme.of(context).colorScheme;
    return BlocBuilder<NotificationListBloc, NotificationListState>(
      builder: (context, state) {
        if (state.isLoading && state.notifications.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.isError) {
          return const Center(child: Text('Error loading notifications'));
        }
        return notifications.isEmpty
            ? _emptyNotificationsView(colors, context)
            : Expanded(
                child: ListView.separated(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) =>
                      _CustomNotification(notification: notifications[index]),
                  separatorBuilder: (context, index) =>
                      const Divider(height: 2),
                ),
              );
      },
    );
  }
}

class _CustomNotification extends StatelessWidget {
  final entity.Notification notification;
  const _CustomNotification({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        title: Text(notification.title),
        subtitle: Text(notification.body),
        leading: const Icon(Icons.notifications_none_outlined),
        onTap: () {},
      ),
    );
  }
}

Center _emptyNotificationsView(ColorScheme colors, BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.notification_important_outlined,
            size: 200, color: colors.secondary),
        Text("Can't find notifications",
            style: TextStyle(fontSize: 20, color: colors.secondary)),
        Text('Let`s explore more context around you',
            style: TextStyle(fontSize: 15, color: colors.secondary)),
        const SizedBox(height: 20),
        SizedBox(
          width: 300,
          child: FilledButton(
            onPressed: () => context.go(('/home/0')),
            child: const Text('Back to Feed', style: TextStyle(fontSize: 20)),
          ),
        )
      ],
    ),
  );
}
