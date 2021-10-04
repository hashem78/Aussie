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
          MaterialPageRoute(
            builder: (context) => MultiProvider(
              providers: [
                Provider.value(value: e),
                Provider.value(value: u),
              ],
              child: const EventDetails(),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: const [
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
                child: const EventDetails(),
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
