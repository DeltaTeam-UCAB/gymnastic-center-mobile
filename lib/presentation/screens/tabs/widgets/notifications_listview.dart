import 'package:flutter/material.dart';
import 'package:gymnastic_center/infrastructure/models/push_message_model.dart';

class NotificationsListView extends StatelessWidget {
  final List<PushMessageModel> notifications;
  const NotificationsListView({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: notifications.length,
      itemBuilder: (context, index) => _CustomNotification(notification: notifications[index]),
      separatorBuilder: (context, index) => const Divider(height: 2), 
    );
  }
}

class _CustomNotification extends StatelessWidget {
  final PushMessageModel notification;
  const _CustomNotification({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        title: Text(notification.title),
        subtitle: Text(notification.body),
        leading: const Icon(Icons.notifications_none_outlined),        
        onTap: (){},
      ),
    );
  }
}