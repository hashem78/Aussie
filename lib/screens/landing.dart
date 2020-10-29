import 'package:Aussie/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(360, 640),
      allowFontScaling: true,
    );
    final kausFlag = Center(
      child: Hero(
        tag: "auFlag",
        child: Image.asset(
          'assests/images/au.png',
          width: .5.sw,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
    final kausOutLine = FractionallySizedBox(
      child: Image.asset(
        'assests/images/auOutLine.png',
        height: .50.sh,
        width: 1.sw,
        fit: BoxFit.scaleDown,
      ),
    );

    return Scaffold(
      body: CustomPaint(
        painter: LandingPainter(),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: .01.sh,
              child: Align(
                child: kausOutLine,
              ),
            ),
            Positioned(
              top: .17.sh,
              child: Align(
                child: Text(
                  "Aussie",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: kausBlue, fontSize: 60),
                ),
              ),
            ),
            kausFlag,
            Positioned(
              bottom: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Oy!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 120,
                    ),
                  ),
                  Container(
                    height: .15.sh,
                    width: .60.sw,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                        primary: kausBlue,
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: kaussieRadius,
                        // ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "/main");
                      },
                      child: Text(
                        "Meet Austrialia!",
                        style: TextStyle(fontSize: 21),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LandingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    Paint paint2 = Paint();
    paint2.color = kausBlue;
    canvas.drawRect(Rect.fromLTWH(0, 0, width, height / 2), paint2);

    Paint paint = Paint();
    paint.color = kausRed;
    canvas.drawRect(Rect.fromLTWH(0, height / 2, width, height / 2), paint);
  }

  @override
  bool shouldRepaint(LandingPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(LandingPainter oldDelegate) => false;
}
