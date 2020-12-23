import 'package:aussie/models/usermanagement/user/user.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreenImage extends StatelessWidget {
  const ProfileScreenImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: buildImage(
        Provider.of<AussieUser>(context).profilePictureLink,
        fit: BoxFit.cover,
      ),
    );
  }
}
