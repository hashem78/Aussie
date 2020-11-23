import 'package:aussie/models/main_screen/entertainment/details.dart';
import 'package:aussie/models/main_screen/main_screen_item.dart';

class EntertainmentItem extends MainScreenItem {
  final String title;
  final String imageUrl;
  final EntertainmentDetailsModel detailsModel;
  EntertainmentItem({
    this.title,
    this.imageUrl,
    this.detailsModel,
  });
}
