import 'package:Aussie/util/functions.dart';
import 'package:Aussie/widgets/%20aussie_scrollable_list.dart';
import 'package:Aussie/widgets/aussie_sliver_appbar.dart';
import 'package:flutter/material.dart';

import 'package:Aussie/screens/details.dart';
import 'package:Aussie/widgets/animated/banner_image.dart';
import 'package:Aussie/widgets/animated/expanded_text_tile.dart';
import 'package:Aussie/widgets/animated/sized_tile.dart';
import 'package:Aussie/widgets/details_heading.dart';

import '../constants.dart';

class Cuisine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: NestedScrollView(
        physics: ClampingScrollPhysics(),
        headerSliverBuilder: (context, __) => [
          AussieSliverAppBar(
            backgroundColor: Colors.green,
            title: "Food & drinks",
            showHero: false,
          )
        ],
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            AussieScrollableList(
              heightFactor: 40,
              childPadding: EdgeInsets.only(right: 1),
              title: "Dishes",
              scrollDirection: Axis.horizontal,
              children: [
                buildSizedImageTile(
                  90,
                  20,
                  url: "https://tinyurl.com/yyaym9sy",
                  title: "Barbqued Snags",
                ),
                buildSizedImageTile(
                  90,
                  20,
                  url: "https://tinyurl.com/y2j9nb26",
                  title: "Meat Pie",
                ),
                buildSizedImageTile(
                  90,
                  20,
                  url: "https://tinyurl.com/y6fn5oyu",
                  title: "Kangaroo Burger",
                ),
                buildSizedImageTile(
                  90,
                  20,
                  url: "https://tinyurl.com/y64mawty",
                  title: "Fairy Bread",
                ),
                buildSizedImageTile(
                  90,
                  20,
                  url: "https://tinyurl.com/y4wsh9th",
                  title: "Calm Pasta",
                ),
              ],
            ),
            AussieScrollableList(
              heightFactor: 40,
              childPadding: EdgeInsets.only(right: 1),
              title: "Desserts",
              scrollDirection: Axis.horizontal,
              children: [
                buildSizedImageTile(
                  90,
                  20,
                  url: "https://tinyurl.com/yxsnnnfo",
                  title: "Pavola",
                ),
                buildSizedImageTile(
                  90,
                  20,
                  url: "https://tinyurl.com/y6ylyxcv",
                  title: "TimTams",
                ),
                buildSizedImageTile(
                  90,
                  20,
                  url: "https://tinyurl.com/y688sk3v",
                  title: "Cherry Ripes",
                ),
                buildSizedImageTile(
                  90,
                  20,
                  url: "https://tinyurl.com/y69pjt3d",
                  title: "Chocolate Crackels",
                ),
                buildSizedImageTile(
                  90,
                  20,
                  url: "https://tinyurl.com/yy849jdz",
                  title: "Anzac Biscuits",
                ),
              ],
            ),
            AussieScrollableList(
              heightFactor: 40,
              childPadding: EdgeInsets.only(right: 1),
              title: "Drinks & Beverages",
              scrollDirection: Axis.horizontal,
              children: [
                buildSizedImageTile(
                  90,
                  20,
                  url: "https://tinyurl.com/yyw3hg6t",
                  title: "Lemon Barely Water",
                ),
                buildSizedImageTile(
                  90,
                  20,
                  url: "https://tinyurl.com/y2f4uue9",
                  title: "Long Black",
                ),
                buildSizedImageTile(
                  90,
                  20,
                  url: "https://tinyurl.com/y2c9asay",
                  title: "Flat White",
                ),
              ],
            ),
            AussieScrollableList(
              heightFactor: 40,
              childPadding: EdgeInsets.all(5),
              title: "Local Cuisine",
              scrollDirection: Axis.horizontal,
              children: [
                buildSizedImageTile(
                  97,
                  20,
                  url: "https://tinyurl.com/yyxg2rag",
                  title: "Chicken Parmigiana",
                ),
                buildSizedImageTile(
                  97,
                  20,
                  url: "https://tinyurl.com/y4ccrxmr",
                  title: "Fire-roasted barramundi",
                ),
                buildSizedImageTile(
                  97,
                  20,
                  url: "https://tinyurl.com/y4e55por",
                  title: "Stuffed lamb rack",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSizedImageTile(int widthFactor, int heighFactor,
      {String url = "https://tinyurl.com/y5923jao", String title}) {
    var image = buildImage(url);
    return AnimatedSizedTile.withDetails(
      swatchColor: Colors.red,
      widthFactor: widthFactor,
      heightFactor: heighFactor,
      title: title,
      image: Hero(
        tag: image.second,
        child: image.first,
      ),
      child: Details(
        backgroundColor: Colors.green,
        title: title,
        top: AnimatedBannerImage(
          heroTag: image.second,
          image: image.first,
          heightFactor: 30,
        ),
        bottom: AussieScrollableList(
          title: "Gallery",
          scrollDirection: Axis.horizontal,
          heightFactor: 36,
          childPadding: EdgeInsets.all(5),
          children: [
            AnimatedSizedTile(
              image: image.first,
              title: "Placeholder",
              widthFactor: 97,
              heightFactor: 20,
              swatchColor: Colors.red,
            ),
            AnimatedSizedTile(
              image: image.first,
              title: "Placeholder",
              widthFactor: 97,
              heightFactor: 20,
              swatchColor: Colors.red,
            ),
          ],
        ),
        sections: [
          Section(
            borderColor: Colors.black,
            children: [
              DetailsHeading(title: title, color: kausBlue),
              AnimatedExpandingTextTile(
                color: Colors.lightBlue,
                title: "What?",
                text: klorem,
              ),
              AnimatedExpandingTextTile(
                color: Colors.pink,
                title: "How it's made",
                text: klorem,
              ),
            ],
          )
        ],
      ),
    );
  }
}
