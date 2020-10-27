import 'package:Aussie/models/efe/efe_item.dart';
import 'package:Aussie/models/efe/explore/events/details.dart';

class EventsItem extends EFEItem {
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
