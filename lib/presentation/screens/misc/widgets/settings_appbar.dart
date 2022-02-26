import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:evento/util/functions.dart';

class SettingsAppbar extends StatelessWidget {
  final String tTitle;
  const SettingsAppbar({
    Key? key,
    required this.tTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: .5.sh,
      title: const Text('Aussie'),
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: <Widget>[
            Center(
              child: Text(
                getTranslation(context, tTitle),
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 200.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
