import 'package:aussie/models/usermanagement/user/user.dart';
import 'package:aussie/presentation/screens/feed/tabs/events/details.dart';
import 'package:aussie/presentation/screens/feed/tabs/events/widgets/card_details.dart';
import 'package:aussie/presentation/screens/feed/widgets/card_image.dart';
import 'package:aussie/presentation/screens/feed/widgets/card_owner.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MultiProvider(
              providers: [
                Provider(
                  create: (context) => AussieUser(
                    profileBannerLink: "https://picsum.photos/1200",
                  ),
                )
              ],
              child: EventDetails(),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardOwner(),
              FeedCardImage(),
              EventCardDetails(),
            ],
          ),
        ),
      ),
    );
  }
}
