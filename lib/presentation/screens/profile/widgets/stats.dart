import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreenCardStats extends StatelessWidget {
  const ProfileScreenCardStats({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.all(10),
      height: 50,
      child: Row(
        children: [
          Expanded(child: Text("#posts")),
          Expanded(child: Text("#followers")),
          Expanded(child: Text("#following")),
        ],
      ),
    );
  }
}
