import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecondRegistrationScreenSubTitle extends StatelessWidget {
  const SecondRegistrationScreenSubTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Register',
          style: TextStyle(fontSize: 130.sp),
        ),
        const Padding(
          padding: EdgeInsetsDirectional.only(top: 8.0),
          child: Text(
            'Continue your registration process',
          ),
        ),
      ],
    );
  }
}
