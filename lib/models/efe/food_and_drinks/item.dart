import 'package:aussie/models/efe/efe_item.dart';

import 'package:aussie/models/efe/food_and_drinks/details.dart';

class FoodAndDrinksItem extends EFEItem {
  final FoodAndDrinksDetailsModel detailsModel;
  const FoodAndDrinksItem({
    String title,
    String imageUrl,
    this.detailsModel,
  }) : super(
          title: title,
          detailsModel: detailsModel,
          imageUrl: imageUrl,
        );
}
