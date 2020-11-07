import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AussieSliverAppBar extends StatelessWidget {
  final String title;

  const AussieSliverAppBar({
    @required this.title,
  }) : assert(title != null);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: .30.sh,
      backgroundColor: Colors.red,
      title: Text("Aussie"),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          child: Stack(
            children: [
              Center(
                child: AutoSizeText(
                  title,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 200.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Icon(Icons.arrow_drop_down),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
