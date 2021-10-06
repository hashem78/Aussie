import 'package:aussie/aussie_imports.dart';

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
          MaterialPageRoute<MultiProvider>(
            builder: (BuildContext context) => MultiProvider(
              providers: <Provider<Object>>[
                Provider<EventModel>.value(value: e),
                Provider<AussieUser>.value(value: u),
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
            MaterialPageRoute<MultiProvider>(
              builder: (BuildContext context) => MultiProvider(
                providers: <Provider<Object>>[
                  Provider<EventModel>.value(value: e),
                  Provider<AussieUser>.value(value: user),
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
                  BlocProvider<UserManagementCubit>(
                    create: (BuildContext context) {
                      return UserManagementCubit()
                        ..isUserAttending(
                          getCurrentUser(context),
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
