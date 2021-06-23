import 'package:aussie/models/event/event_model.dart';
import 'package:aussie/models/usermanagement/user/user_model.dart';
import 'package:aussie/presentation/screens/feed/events/event_details.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/card_details.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/public_event_attend_button.dart';
import 'package:aussie/presentation/screens/feed/widgets/card_owner.dart';
import 'package:aussie/presentation/screens/feed/widgets/event_card_image.dart';
import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';

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
    final AussieUser u = getCurrentUser(context);
    return Card(
      shape: const RoundedRectangleBorder(),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MultiProvider(
              providers: [
                Provider.value(value: e),
                Provider.value(value: u),
              ],
              child: EventDetails(),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: const [
              CardOwner(),
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

class PublicEventCard extends StatefulWidget {
  const PublicEventCard({
    Key? key,
  }) : super(key: key);

  @override
  _PublicEventCardState createState() => _PublicEventCardState();
}

class _PublicEventCardState extends State<PublicEventCard>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final EventModel e = getEventModel(context);
    final AussieUser user = getCurrentUser(context);

    return Card(
      shape: const RoundedRectangleBorder(),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MultiProvider(
                providers: [
                  Provider.value(
                    value: e,
                  ),
                  Provider.value(value: user),
                ],
                child: EventDetails(),
              ),
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
                  BlocProvider(
                    create: (context) => UserManagementCubit()
                      ..isUserAttending(getCurrentUser(context), e),
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
