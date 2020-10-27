import 'package:Aussie/models/efe/efe.dart';

abstract class EFEItem<T extends EFEModel> {
  final String title;
  final String imageUrl;
  final T detailsModel;
  const EFEItem({
    this.title,
    this.imageUrl,
    this.detailsModel,
  });
}
