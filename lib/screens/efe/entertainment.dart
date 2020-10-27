import 'package:Aussie/constants.dart';
import 'package:Aussie/models/efe/entertainment/details.dart';
import 'package:Aussie/models/gallery.dart';

import 'package:Aussie/models/ratings.dart';
import 'package:Aussie/screens/efe/efe.dart';
import 'package:Aussie/util/social_media_platform.dart';
import 'package:flutter/material.dart';

import 'package:Aussie/util/functions.dart';

import 'package:Aussie/widgets/aussie/sliver_appbar.dart';

var _col = getRandomColor();

class Entertainment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var tmodel = EntertainmentDetailsModel(
        title: "Rabbit Proof",
        titleImageUrl: kurl,
        galleryImageLinks: [GalleryImageModel(url: kurl, title: "lol")],
        socialMediaPlatforms: {SocialMediaPlatform.facebook: ""},
        descriptions: {"hi": klorem},
        ratingModels: [RatingsModel(3, "hashem", klorem)]);
    return Scaffold(
      backgroundColor: _col,
      body: NestedScrollView(
        physics: ClampingScrollPhysics(),
        headerSliverBuilder: (context, __) => [
          AussieSliverAppBar(
            backgroundColor: _col,
            title: "Entertainment",
            showHero: false,
          )
        ],
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            EFEScreen.buildEFETiles(
                "Movies", List.filled(5, tmodel), 60, 20, 55),
            EFEScreen.buildEFETiles(
                "Movies", List.filled(5, tmodel), 60, 20, 50),
          ],
        ),
      ),
    );
  }
}

// class EntertainmentDetails extends StatelessWidget {
//   final Color backgroundColor;
//   final EntertainmentDetailsModel model;
//   const EntertainmentDetails({
//     @required this.model,
//     this.backgroundColor = Colors.blue,
//   }) : assert(model != null);

//   @override
//   Widget build(BuildContext context) {
//     var _titleImgae = buildImage(model.titleImageUrl);
//     var _gallery = model.galleryImageLinks.map(
//       (e) {
//         var _image = buildImage(e.url);
//         return AnimatedSizedTile(title: e.title, image: _image.first);
//       },
//     ).toList();
//     var _descriptions = <ExpandingTextTile>[];
//     model.descriptions.forEach((key, value) =>
//         _descriptions.add(ExpandingTextTile(title: key, text: value)));
//     var _geners = model.geners.reduce((value, element) => '$value, $element');
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       body: NestedScrollView(
//         headerSliverBuilder: (_, __) => [
//           AussieSliverAppBar(
//             backgroundColor: backgroundColor,
//             title: model.title,
//             showHero: false,
//             automaticallyImplyLeading: true,
//           )
//         ],
//         body: ListView(
//           addAutomaticKeepAlives: true,
//           physics: BouncingScrollPhysics(),
//           children: [
//             AnimatedBannerImage(
//               heroTag: _titleImgae.second,
//               image: _titleImgae.first,
//               heightFactor: 70,
//             ),
//             Section(
//               children: [
//                 SocialsIconRow(model.socialMediaPlatforms),
//                 DetailsHeading(title: model.title, color: Colors.white),
//                 ..._descriptions,
//               ],
//             ),
//             Text(_geners),
//             AussieScrollableList(
//               title: "Gallery",
//               scrollDirection: Axis.horizontal,
//               heightFactor: 50,
//               childPadding: EdgeInsets.all(5),
//               children: _gallery,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
