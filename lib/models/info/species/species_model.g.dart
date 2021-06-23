// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'species_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpeciesDetailsModel _$SpeciesDetailsModelFromJson(Map<String, dynamic> json) {
  return $checkedNew('SpeciesDetailsModel', json, () {
    final val = SpeciesDetailsModel(
      commonName: $checkedConvert(json, 'commonName', (v) => v as String?),
      scientificName:
          $checkedConvert(json, 'scientificName', (v) => v as String?),
      type: $checkedConvert(json, 'type', (v) => v as String?),
      conservationStatus:
          $checkedConvert(json, 'conservationStatus', (v) => v as String?),
      description: $checkedConvert(json, 'description', (v) => v as String?),
      titleImageUrl:
          $checkedConvert(json, 'titleImageUrl', (v) => v as String?),
      imageUrls: $checkedConvert(json, 'imageUrls',
          (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
    );
    return val;
  });
}
