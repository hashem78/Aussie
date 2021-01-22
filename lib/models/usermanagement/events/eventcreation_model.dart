import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class AussieByteData {
  final ByteData byteData;
  final int width;
  final int height;

  AussieByteData({
    this.byteData,
    this.width,
    this.height,
  });
}

@immutable
class EventCreationModel extends Equatable {
  final int startingTimeStamp;
  final int endingTimeStamp;
  final String description;
  final String title;
  final String subtitle;
  final String address;

  final String eventId = Uuid().v4();
  final double lat;
  final double lng;

  final List<AussieByteData> imageData;
  final AussieByteData bannerData;

  EventCreationModel({
    this.startingTimeStamp,
    this.endingTimeStamp,
    this.description,
    this.lat,
    this.lng,
    this.title,
    this.subtitle,
    this.imageData,
    this.bannerData,
    this.address,
  });

  @override
  List<Object> get props {
    return [
      startingTimeStamp,
      endingTimeStamp,
      description,
      title,
      subtitle,
      lat,
      lng,
      address,
    ];
  }
}
