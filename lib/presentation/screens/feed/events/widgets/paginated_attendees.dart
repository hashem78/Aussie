import 'package:aussie/aussie_imports.dart';
import 'package:aussie/providers/providers.dart';
import 'package:aussie/repositories/user_management_repository.dart';
import 'package:aussie/state/event_management.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class PaginatedAtendees extends ConsumerWidget {
  const PaginatedAtendees({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final event = ref.watch(scopedEventProvider);
    return FirestoreQueryBuilder<String>(
      query: AttendeesRepository.fetchAttendees(event.eventId),
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
            return FutureBuilder<AussieUser>(
              future: UMRepository.getUserDataFromUid(event),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ProviderScope(
                    overrides: [
                      scopedUserProvider.overrideWithValue(snapshot.data!)
                    ],
                    child:  CardOwner(
                      heroTag: const Uuid().v4(),
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            );
          },
        );
      },
    );
  }
}
