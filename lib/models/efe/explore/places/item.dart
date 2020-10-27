import 'package:Aussie/models/efe/efe_item.dart';
import 'package:Aussie/models/efe/explore/places/details.dart';

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
