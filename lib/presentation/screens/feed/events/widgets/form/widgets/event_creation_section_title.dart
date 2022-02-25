import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventCreationSectionTitle extends StatelessWidget {
  const EventCreationSectionTitle({
    Key? key,
    required this.text,
    required this.iconData,
  }) : super(key: key);
  final String text;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: Colors.black.withOpacity(.5),
        ),
        SizedBox(
          width: 0.03.sw,
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 75.sp,
              color: Colors.black.withOpacity(.5),
            ),
          ),
        ),
      ],
    );
  }
}
