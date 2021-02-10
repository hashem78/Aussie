import 'package:aussie/models/usermanagement/user/user_model.dart';
import 'package:aussie/util/functions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ProfileScreenCardDetails extends StatelessWidget {
  const ProfileScreenCardDetails({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AussieUser user = getCurrentUser(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          user.fullname,
          maxLines: 1,
          style: Theme.of(context).textTheme.headline5,
        ),
        AutoSizeText(
          user.username,
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}
