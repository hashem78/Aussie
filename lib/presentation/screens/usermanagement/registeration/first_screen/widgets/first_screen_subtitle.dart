import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirstRegistrationScreenHeader extends StatelessWidget {
  const FirstRegistrationScreenHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Register',
          style: TextStyle(fontSize: 130.sp),
        ),
        Row(
          children: [
            const Text(
              'Already have an account?',
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Sign In'),
            ),
          ],
        ),
      ],
    );
  }
}
