import 'package:flutter/material.dart';

class EventCardDetailsHeader extends StatelessWidget {
  const EventCardDetailsHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "#type",
          style: Theme.of(context).textTheme.caption,
        ),
        Text(
          "#remaing time",
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}
