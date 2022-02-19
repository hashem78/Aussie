import 'package:aussie/models/models.dart';
import 'package:aussie/presentation/screens/feed/events/event_details.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/card_details.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/public_event_attend_button.dart';
import 'package:aussie/presentation/screens/feed/widgets/card_owner.dart';
import 'package:aussie/presentation/screens/feed/widgets/event_card_image.dart';
import 'package:aussie/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as p;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aussie/util/utlis.dart';

import 'package:aussie/state/attendees_cubit/attendees_cubit.dart';

class EventCard extends StatefulWidget {
  const EventCard({
    Key? key,
  }) : super(key: key);

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final EventModel e = getEventModel(context);
    return Card(
      shape: const RoundedRectangleBorder(),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute<p.MultiProvider>(
            builder: (BuildContext context) => p.MultiProvider(
              providers: [
                p.Provider<EventModel>.value(value: e),
              ],
              child: const EventDetails(),
            ),
          ),
        ),
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

  @override
  bool get wantKeepAlive => true;
}

class PublicEventCard extends ConsumerStatefulWidget {
  const PublicEventCard({
    Key? key,
  }) : super(key: key);

  @override
  _PublicEventCardState createState() => _PublicEventCardState();
}

class _PublicEventCardState extends ConsumerState<PublicEventCard>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final e = getEventModel(context);
    final user = ref.watch(remoteUserProvider(e.uid));
    return user.when(loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }, data: (user) {
      return ProviderScope(
        overrides: [
          scopedUserProvider.overrideWithValue(user),
        ],
        child: Card(
          shape: const RoundedRectangleBorder(),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<p.MultiProvider>(
                  builder: (context) => p.MultiProvider(
                    providers: [
                      p.Provider<EventModel>.value(value: e),
                    ],
                    child: const EventDetails(),
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Expanded(child: CardOwner()),
                      BlocProvider<AttendeesCubit>(
                        create: (BuildContext context) {
                          return AttendeesCubit()
                            ..isUserAttending(
                              user.mapOrNull(signedIn: (value) => value.uid)!,
                              e,
                            );
                        },
                        child: const PublicAttendButton(),
                      ),
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

  @override
  bool get wantKeepAlive => true;
}
