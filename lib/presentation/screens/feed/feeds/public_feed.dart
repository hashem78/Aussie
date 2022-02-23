import 'package:aussie/aussie_imports.dart';
import 'package:aussie/repositories/event_management_repository.dart';
import 'package:aussie/state/event_management.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:uuid/uuid.dart';

class PublicFeed extends StatelessWidget {
  const PublicFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder<EventModel>(
      query: EventManagementRepository.fetchPublicEvents(),
      builder: (context, snapshot, child) {
        if (snapshot.isFetching) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('error ${snapshot.error}');
        }
        return ListView.builder(
          itemCount: snapshot.docs.length,
          itemBuilder: (context, index) {
            if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
              snapshot.fetchMore();
            }
            final event = snapshot.docs[index].data();
            return ProviderScope(
              overrides: [
                scopedEventProvider.overrideWithValue(event),
              ],
              child: PublicEventCard(
                heroTag: const Uuid().v4(),
              ),
            );
          },
        );
      },
    );
  }
}
