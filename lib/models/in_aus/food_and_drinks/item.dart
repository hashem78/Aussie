import 'package:aussie/models/in_aus/food_and_drinks/details.dart';
import 'package:aussie/models/in_aus/main_screen_item.dart';

class FoodAndDrinksItem extends MainScreenItem {
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
