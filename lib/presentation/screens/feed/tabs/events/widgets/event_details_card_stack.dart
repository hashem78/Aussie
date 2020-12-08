import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aussie/presentation/screens/feed/widgets/card_owner.dart';

class EventCardStack extends StatelessWidget {
  const EventCardStack({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    return Container(
      height: .3.sh,
      width: .9.sw,
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        child: Column(
          children: [
            Material(
              type: MaterialType.transparency,
              child: CardOwner(
                size: .25.sw,
              ),
            ),
            Column(
              children: [
                AutoSizeText(
                  "# Title",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4,
                ),
                AutoSizeText(
                  "# Subtitle",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
                Text(
                  "${today.year.toString()}/${today.month.toString().padLeft(2, '0')}/${today.day.toString().padLeft(2, '0')}",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
