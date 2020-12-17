import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventCardAttendees extends StatelessWidget {
  const EventCardAttendees({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Expanded(
              child: Stack(
                overflow: Overflow.visible,
                alignment: FractionalOffset.bottomLeft,
                children: [
                  Positioned(
                    child: Container(
                      width: .05.sh,
                      height: .05.sh,
                      color: Colors.red,
                    ),
                  ),
                  Positioned(
                    left: .05.sw,
                    child: Container(
                      width: .05.sh,
                      height: .05.sh,
                      color: Colors.green,
                    ),
                  ),
                  Positioned(
                    left: .1.sw,
                    child: Container(
                      width: .05.sh,
                      height: .05.sh,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: AutoSizeText(
                "Hashem, Mono, yoloo",
                overflow: TextOverflow.ellipsis,
                minFontSize: 14,
                maxLines: 1,
              ),
            ),
          ],
        ),
        Text(
          "And #X others are attending",
          style: Theme.of(context).textTheme.caption,
        )
      ],
    );
  }
}
