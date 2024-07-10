import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/clients/link-device/link_device_bloc.dart';
import 'package:gymnastic_center/application/notifications/bloc/notifications_bloc.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';
import 'package:gymnastic_center/injector.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsBloc, NotificationsState>(
        builder: (context, state) {
      if (!state.status || state.token.isEmpty) {
        return const _NotAllowedNotificationView();
      }

      return BlocProvider(
        create: (_) => getIt<LinkDeviceBloc>()..checkDeviceLink(state.token),
        child: _SynchronizeDevicesView(state.token),
      );
    });
  }
}

class _SynchronizeDevicesView extends StatelessWidget {
  final String token;
  const _SynchronizeDevicesView(this.token);

  @override
  Widget build(BuildContext context) {
    final isDark = context.read<ThemesBloc>().isDarkMode;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
        appBar: AppBar(title: const Text('Privacy')),
        body: BlocBuilder<LinkDeviceBloc, LinkDeviceState>(
          builder: (context, state) {
            if (state.status == LinkDeviceStatus.chekingDevice) {
              return FadeIn(
                child: const Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Text('Checking devices 🔄')
                      ]),
                ),
              );
            }

            if ((state.status == LinkDeviceStatus.deviceCheked &&
                    state.isLinked) ||
                state.status == LinkDeviceStatus.success) {
              return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    ElasticIn(
                        child: SvgPicture.asset(
                            'assets/notification-allowed.svg',
                            height: 350)),
                    Text(
                      state.status == LinkDeviceStatus.success
                          ? 'Devices synchronized successfully 🎉'
                          : 'Devices already synchronized 🎉',
                      style: const TextStyle(fontSize: 18),
                    )
                  ]));
            }

            if (state.status == LinkDeviceStatus.failure) {
              return const Center(
                  child: Text('Failed to synchronize devices 🔄'));
            }

            if (state.status == LinkDeviceStatus.linking) {
              return const Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text('Synchronizing devices 🔄')
                    ]),
              );
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElasticIn(
                      child: SvgPicture.asset('assets/privacy-device.svg',
                          height: 350)),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 20, 20),
                    child: Text(
                        'Link this device to receive your recovery codes \nas push notifications 📲'),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 50),
                        backgroundColor: isDark ? Colors.white : colors.primary,
                      ),
                      onPressed: () =>
                          context.read<LinkDeviceBloc>().linkDevice(token),
                      child: Text(
                        'Link device!',
                        style: TextStyle(
                            color:
                                isDark ? colors.inversePrimary : Colors.white),
                      )),
                ],
              ),
            );
          },
        ));
  }
}

class _NotAllowedNotificationView extends StatelessWidget {
  const _NotAllowedNotificationView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy')),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('Notifications are not allowed 🚫'),
          const Text('Please enable them in your settings 📲 (Notifications)'),
          TextButton.icon(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => context.pop(),
            label: const Text('Return to settings'),
          ),
        ]),
      ),
    );
  }
}
