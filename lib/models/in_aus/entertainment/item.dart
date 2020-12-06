import 'package:aussie/models/in_aus/entertainment/details.dart';
import 'package:aussie/models/in_aus/main_screen_item.dart';

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
