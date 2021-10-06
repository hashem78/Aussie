import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aussie/models/gmap.dart';
import 'package:aussie/models/info/natural_parks/natural_parks_model.dart';
import 'package:aussie/models/themes/color_data_model.dart';
import 'package:aussie/presentation/screens/gmap_screen.dart';
import 'package:aussie/util/functions.dart';

class NaturalParksDetailsScreen extends StatelessWidget {
  final NaturalParkModel model;
  final String heroTag;
  const NaturalParksDetailsScreen({
    Key? key,
    required this.model,
    required this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AussieThemeProvider.of(context)!.color.backgroundColor,
        appBar: AppBar(
          backgroundColor: AussieThemeProvider.of(context)!.color.swatchColor,
          elevation: 0,
          title: Text(model.park_name!),
          flexibleSpace: model.image_link != ''
              ? Hero(
                  tag: heroTag,
                  child: buildImage(model.image_link, fit: BoxFit.cover)!,
                )
              : null,
          bottom: const TabBar(
            tabs: <Icon>[
              Icon(Icons.info),
              Icon(Icons.map),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            ListView.builder(
              itemCount: model.sections!.length,
              itemBuilder: (BuildContext context, int index) {
                final String sectionTitle =
                    model.sections![index]['title']!.trim();
                final String sectionText =
                    model.sections![index]['text']!.trim();
                if (sectionText == '') {
                  return const SizedBox();
                }
                return Card(
                  color: Colors.cyan,
                  shape: const RoundedRectangleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          sectionTitle,
                          style: TextStyle(
                            fontSize: 100.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        ExpandText(
                          '   $sectionText',
                          maxLines: 5,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            AussieGMap(
              size: Size(double.infinity, .4.sh),
              model: AussieGMapModel(
                latitude: model.latitude,
                longitude: model.longitude,
                title: model.park_name,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
