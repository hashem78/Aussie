import 'package:aussie/presentation/screens/feed/events/widgets/description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'card_header.dart';

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
        ],
      ),
    );
  }
}
