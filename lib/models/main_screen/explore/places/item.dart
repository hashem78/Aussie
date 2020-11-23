import 'package:aussie/models/main_screen/explore/places/details.dart';
import 'package:aussie/models/main_screen/main_screen_item.dart';

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
