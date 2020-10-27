import 'package:Aussie/models/efe/efe_item.dart';
import 'package:Aussie/models/efe/entertainment/details.dart';

class EntertainmentItem extends EFEItem {
  final String title;
  final String imageUrl;
  final EntertainmentDetailsModel detailsModel;
  EntertainmentItem({
    this.title,
    this.imageUrl,
    this.detailsModel,
  });
}