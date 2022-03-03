import 'package:evento/models/event/event_model.dart';
import 'package:evento/presentation/screens/events/widgets/card.dart';
import 'package:evento/presentation/widgets/app_drawer.dart';
import 'package:evento/presentation/widgets/scaffold.dart';
import 'package:evento/repositories/event_management_repository.dart';
import 'package:evento/state/event_management.dart';
import 'package:evento/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:uuid/uuid.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AussieScaffold(
      drawer: const AussieAppDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          getTranslation(context, 'feedScreenTitle'),
          style: TextStyle(
            fontSize: 100.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: FirestoreQueryBuilder<EventModel>(
          query: EventManagementRepository.fetchPublicEvents(),
          builder: (context, snapshot, child) {
            if (snapshot.isFetching) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('error ${snapshot.error}'));
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
        ),
      ),
    );
  }
}
