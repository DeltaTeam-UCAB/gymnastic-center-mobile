import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/notifications/notification_list_bloc.dart';
import 'package:gymnastic_center/domain/entities/notifications/notification.dart'
    as entity;
import 'package:timeago/timeago.dart' as timeago;

class NotificationsListView extends StatefulWidget {
  const NotificationsListView({super.key});
  @override
  State<NotificationsListView> createState() => _NotificationsListViewState();
}

class _NotificationsListViewState extends State<NotificationsListView> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    context.read<NotificationListBloc>().loadNextPage();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels + 400 >=
          _scrollController.position.maxScrollExtent) {
        context.read<NotificationListBloc>().loadNextPage();
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
    final colors = Theme.of(context).colorScheme;
    return BlocBuilder<NotificationListBloc, NotificationListState>(
      builder: (context, state) {
        if (state.isLoading && state.notifications.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.isError) {
          return const Center(child: Text('Error loading notifications'));
        }
        return state.notifications.isEmpty
            ? _emptyNotificationsView(colors, context)
            : Expanded(
                child: ListView.separated(
                  itemCount: state.notifications.length,
                  itemBuilder: (context, index) => _CustomNotification(
                      notification: state.notifications[index]),
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
    return NotificationListItem(
      id: notification.id,
      title: notification.title,
      body: notification.body,
      date: notification.date,
      read: notification.read,
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

class NotificationListItem extends StatefulWidget {
  const NotificationListItem(
      {super.key,
      required this.id,
      required this.title,
      required this.body,
      required this.date,
      required this.read});

  final String id;
  final String title;
  final String body;
  final DateTime date;
  final bool read;

  @override
  State<NotificationListItem> createState() => _NotificationListItemState();
}

class _NotificationListItemState extends State<NotificationListItem> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        if (!widget.read) {
          context.read<NotificationListBloc>().markNotificationRead(widget.id);
        }
        setState(() {
          expanded = !expanded;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(13, 19, 0, 0),
                child: Icon(
                  Icons.notifications,
                  color: widget.read ? colors.secondary : colors.primary,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              flex: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    timeago.format(widget.date),
                    style: const TextStyle(fontSize: 11),
                  ),
                  Text(
                    widget.title,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color:
                            widget.read ? colors.onBackground : colors.primary),
                  ),
                  Text(
                    widget.body,
                    overflow:
                        expanded ? TextOverflow.clip : TextOverflow.ellipsis,
                    style: TextStyle(color: colors.secondary),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                widget.read ? 'Seen' : 'New',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(
              width: 15,
            )
          ],
        ),
      ),
    );
  }
}
