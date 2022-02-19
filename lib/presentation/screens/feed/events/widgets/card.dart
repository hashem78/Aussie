import 'package:aussie/presentation/screens/feed/events/event_details.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/card_details.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/public_event_attend_button.dart';
import 'package:aussie/presentation/screens/feed/widgets/card_owner.dart';
import 'package:aussie/presentation/screens/feed/widgets/event_card_image.dart';
import 'package:aussie/providers/providers.dart';
import 'package:aussie/state/event_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventCard extends ConsumerWidget {
  const EventCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shape: const RoundedRectangleBorder(),
      child: InkWell(
        onTap: () {
          final event = ref.read(scopedEventProvider);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ProviderScope(
                  overrides: [
                    scopedEventProvider.overrideWithValue(event),
                  ],
                  child: const EventDetails(),
                );
              },
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: const <Widget>[
              EventCardImage(),
              EventCardDetails(),
            ],
          ),
        ),
      ),
    );
  }
}

class PublicEventCard extends ConsumerWidget {
  const PublicEventCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final e = ref.watch(scopedEventProvider);
    final user = ref.watch(remoteUserProvider(e.uid));
    final localUser = ref.watch(localUserProvider);

    return user.when(loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }, data: (user) {
      final isLoggedInUser = user.mapOrNull(
        signedIn: (u) => u.uid == localUser.mapOrNull(signedIn: (u) => u.uid)!,
      )!;
      return ProviderScope(
        overrides: [
          scopedUserProvider.overrideWithValue(user),
          scopedEventProvider.overrideWithValue(e),
        ],
        child: Card(
          shape: const RoundedRectangleBorder(),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const EventDetails();
                  },
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(child: CardOwner()),
                      if (!isLoggedInUser) const PublicAttendButton(),
                    ],
                  ),
                  const EventCardImage(),
                  const EventCardDetails(),
                ],
              ),
            ),
          ),
        ),
      );
    }, error: (err, st) {
      return Text(err as String);
    });
  }
}
