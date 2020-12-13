import 'package:aussie/presentation/screens/profile/profile_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CardOwner extends StatelessWidget {
  final double size;

  CardOwner({
    Key key,
    double size,
  })  : size = size ?? .1.sw,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return UserProfileScreen();
            },
          ),
        );
      },
      child: Row(
        children: [
          Container(
            width: size,
            height: size,
            margin: const EdgeInsets.all(5),
            child: Ink.image(
              image: CachedNetworkImageProvider(
                "https://picsum.photos/200",
              ),
            ),
          ),
          SizedBox(width: .05.sw),
          Text(
            "Ali al mestrihi",
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
