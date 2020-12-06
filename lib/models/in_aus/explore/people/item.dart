import 'package:aussie/models/in_aus/explore/people/details.dart';
import 'package:aussie/models/in_aus/main_screen_item.dart';

class PeoplesItem extends MainScreenItem {
  final PeopleDetailsModel detailsModel;
  PeoplesItem({
    String title,
    String imageUrl,
    this.detailsModel,
  }) : super(
          title: title,
          detailsModel: detailsModel,
          imageUrl: imageUrl,
        );
}
