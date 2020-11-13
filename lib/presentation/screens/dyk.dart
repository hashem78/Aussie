import 'package:aussie/models/dyk/dyk.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aussie/util/functions.dart';

class DYKScreen extends StatefulWidget {
  static final title = "Did you know?";
  static final navPath = "/dyk";
  static final svgName = "dyk.svg";

  final List<DYKModel> models;

  DYKScreen({models})
      : models = models ?? List.generate(10, (index) => DYKModel(text: "hi"));
  @override
  _DYKScreenState createState() => _DYKScreenState();
}

class _DYKScreenState extends State<DYKScreen> {
  bool left;
  bool right;
  @override
  void initState() {
    left = false;
    right = true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                color: Colors.red,
                height: .5.sh,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: ClipOval(
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
              ),
              FractionalTranslation(
                translation: Offset(0, 2.3),
                child: Center(
                  child: Text(
                    DYKScreen.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 150.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              if (right)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Icon(Icons.arrow_right),
                ),
              if (left)
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Icon(Icons.arrow_left),
                ),
            ],
          ),
          SizedBox(
            height: .5.sh,
            child: PageView.builder(
              onPageChanged: (page) {
                setState(() {
                  if (page > 0 && page < widget.models.length - 1) {
                    left = true;
                    right = true;
                  } else if (page == 0) {
                    left = false;
                    right = true;
                  } else if (page == widget.models.length - 1) {
                    left = true;
                    right = false;
                  }
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  color: getRandomColor(),
                  child: Center(
                    child: AutoSizeText(
                      widget.models[index].text,
                      style: TextStyle(
                        fontSize: 250.sp,
                      ),
                    ),
                  ),
                );
              },
              itemCount: widget.models.length,
            ),
          ),
        ],
      ),
    );
  }
}
