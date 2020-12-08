import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class ProfileScreenCardDetails extends StatelessWidget {
  const ProfileScreenCardDetails({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          "Hashem Alayan",
          style: TextStyle(fontSize: 70.sp),
        ),
        AutoSizeText(
          "@hashAl",
          style: TextStyle(
            fontSize: 30.sp,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: .02.sh),
        AutoSizeText(
          "Hashem Alayan",
          style: TextStyle(fontSize: 40.sp),
        ),
      ],
    );
  }
}
