import 'package:aussie/presentation/screens/profile/widgets/details.dart';
import 'package:aussie/presentation/screens/profile/widgets/image.dart';
import 'package:aussie/presentation/screens/profile/widgets/stats.dart';

import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: const <Widget>[
              ProfileScreenImage(),
              SizedBox(width: 10),
              Expanded(child: ProfileScreenCardDetails()),
            ],
          ),
          const ProfileScreenCardStats(),
        ],
      ),
    );
  }
}
