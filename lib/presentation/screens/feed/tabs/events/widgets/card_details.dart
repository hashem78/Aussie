import 'package:aussie/presentation/screens/feed/tabs/events/widgets/atendees.dart';
import 'package:aussie/presentation/screens/feed/tabs/events/widgets/card_header.dart';
import 'package:aussie/presentation/screens/feed/tabs/events/widgets/description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventCardDetails extends StatelessWidget {
  const EventCardDetails({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(.05.sw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EventCardDetailsHeader(),
          EventCardDescription(),
          EventCardAtendees(),
        ],
      ),
    );
  }
}
