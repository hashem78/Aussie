import 'package:aussie/models/in_aus/explore/events/details.dart';
import 'package:aussie/models/in_aus/main_screen_item.dart';

class EventsItem extends MainScreenItem {
  final EventDetailsModel detailsModel;
  EventsItem({
    String title,
    String imageUrl,
    this.detailsModel,
  }) : super(
          title: title,
          detailsModel: detailsModel,
          imageUrl: imageUrl,
        );
}
