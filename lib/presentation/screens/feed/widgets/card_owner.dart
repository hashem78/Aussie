import 'package:aussie/presentation/screens/profile/profile_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FeedCardOwner extends StatelessWidget {
  const FeedCardOwner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ProfileScreen();
            },
          ),
        );
      },
      child: Row(
        children: [
          Container(
            width: .1.sw,
            height: .1.sw,
            child: Ink.image(
              image: CachedNetworkImageProvider(
                "https://picsum.photos/200",
              ),
            ),
          ),
          SizedBox(width: .05.sw),
          Text("Ali al mestrihi"),
        ],
      ),
    );
  }
}
