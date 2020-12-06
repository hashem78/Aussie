import 'package:aussie/models/in_aus/main_screen_details.dart';

abstract class MainScreenItem<T extends MainScreenDetailsModel> {
  final String title;
  final String imageUrl;
  final T detailsModel;
  const MainScreenItem({
    this.title,
    this.imageUrl,
    this.detailsModel,
  });
}
