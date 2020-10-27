import 'package:Aussie/models/efe/efe_item.dart';
import 'package:Aussie/models/efe/explore/people/details.dart';

class PeoplesItem extends EFEItem {
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
