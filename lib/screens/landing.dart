import 'package:Aussie/constants.dart';
import 'package:Aussie/size_config.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final kausFlag = Center(
      child: Hero(
        tag: "auFlag",
        child: Image.asset(
          'assests/images/au.png',
          height: 50 * SizeConfig.blockSizeVertical,
          width: 50 * SizeConfig.blockSizeHorizontal,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
    final kausOutLine = FractionallySizedBox(
      child: Image.asset(
        'assests/images/auOutLine.png',
        height: 50 * SizeConfig.blockSizeVertical,
        width: 80 * SizeConfig.blockSizeHorizontal,
        fit: BoxFit.scaleDown,
      ),
    );

    return Scaffold(
      body: CustomPaint(
        painter: MainScreenPainter(),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: SizeConfig.blockSizeVertical,
              child: Align(
                child: kausOutLine,
              ),
            ),
            Positioned(
              top: 17 * SizeConfig.blockSizeVertical,
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
                    height: SizeConfig.blockSizeVertical * 15,
                    width: SizeConfig.blockSizeHorizontal * 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                        primary: kausBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: kaussieRadius,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "/explore");
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

class MainScreenPainter extends CustomPainter {
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
  bool shouldRepaint(MainScreenPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(MainScreenPainter oldDelegate) => false;
}
