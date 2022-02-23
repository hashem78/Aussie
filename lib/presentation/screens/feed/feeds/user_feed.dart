import 'package:aussie/aussie_imports.dart';
import 'package:aussie/providers/providers.dart';
import 'package:aussie/repositories/event_management_repository.dart';
import 'package:aussie/state/event_management.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';

class UserFeed extends ConsumerWidget {
  const UserFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(scopedUserProvider);
    final uid = user.mapOrNull(signedIn: (u) => u.uid)!;
    return FirestoreQueryBuilder<EventModel>(
      query: EventManagementRepository.fetchEventsForUser(uid),
      builder: (context, snapshot, child) {
        if (snapshot.hasError) {
          return Text('error ${snapshot.error}');
        }
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: snapshot.docs.length,
          itemBuilder: (context, index) {
            if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
              snapshot.fetchMore();
            }
            final event = snapshot.docs[index].data();
            return ProviderScope(
              overrides: [scopedEventProvider.overrideWithValue(event)],
              child: const EventCard(),
            );
          },
        );
      },
    );
  }
}
