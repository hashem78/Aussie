import 'package:aussie/models/in_aus/explore/places/details.dart';
import 'package:aussie/models/in_aus/main_screen_item.dart';

class PlacesItem extends MainScreenItem {
  final PlacesDetailsModel detailsModel;
  PlacesItem({
    String title,
    String imageUrl,
    this.detailsModel,
  }) : super(
          title: title,
          detailsModel: detailsModel,
          imageUrl: imageUrl,
        );
}
