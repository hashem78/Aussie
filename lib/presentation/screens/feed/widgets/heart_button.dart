import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeartButton extends StatelessWidget {
  const HeartButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Icon(Icons.thumb_up),
          SizedBox(width: .01.sw),
          Text("Like"),
        ],
      ),
    );
  }
}
