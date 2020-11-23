import 'package:aussie/models/main_screen/food_and_drinks/details.dart';
import 'package:aussie/models/main_screen/main_screen_item.dart';

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
