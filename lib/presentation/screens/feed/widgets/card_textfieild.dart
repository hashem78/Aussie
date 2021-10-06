import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedCardTextField extends StatelessWidget {
  const FeedCardTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Leave a comment!',
        hintStyle: TextStyle(fontSize: 40.sp),
        icon: Container(
          width: .1.sw,
          height: .1.sw,
          color: Colors.blue,
        ),
        filled: true,
        border: InputBorder.none,
        isDense: true,
      ),
    );
  }
}
