import 'package:aussie/presentation/screens/profile/widgets/details.dart';
import 'package:aussie/presentation/screens/profile/widgets/image.dart';
import 'package:aussie/presentation/screens/profile/widgets/stats.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        shape: const RoundedRectangleBorder(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  ProfileScreenImage(),
                  SizedBox(width: 10),
                  ProfileScreenCardDetails(),
                ],
              ),
            ),
            const ProfileScreenCardStats(),
          ],
        ),
      ),
    );
  }
}
