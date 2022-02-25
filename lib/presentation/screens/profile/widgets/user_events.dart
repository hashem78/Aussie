import 'package:aussie/models/event/event_model.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/card.dart';
import 'package:aussie/repositories/event_management_repository.dart';
import 'package:aussie/state/event_management.dart';
import 'package:aussie/state/user_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';

class UserEvents extends ConsumerWidget {
  const UserEvents({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(scopedUserProvider);
    final uid = user.mapOrNull(signedIn: (u) => u.uid)!;
    return FirestoreQueryBuilder<EventModel>(
      query: EventManagementRepository.fetchEventsForUser(uid),
      builder: (context, snapshot, child) {
        if (snapshot.hasData && snapshot.docs.isEmpty) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Text('There are no events'),
            ),
          );
        }
        if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text('error ${snapshot.error}'),
            ),
          );
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
                snapshot.fetchMore();
              }
              final event = snapshot.docs[index].data();
              return ProviderScope(
                overrides: [scopedEventProvider.overrideWithValue(event)],
                child: const EventCard(),
              );
            },
            childCount: snapshot.docs.length,
          ),
        );
      },
    );
  }
}
