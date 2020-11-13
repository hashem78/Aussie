import 'package:aussie/models/efe/efe_item.dart';
import 'package:aussie/models/efe/explore/places/details.dart';

class PlacesItem extends EFEItem {
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
