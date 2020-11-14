import 'package:aussie/models/gmap.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AussieGMap extends StatelessWidget {
  final AussieGMapModel model;
  final Size size;
  AussieGMap({
    @required this.model,
    @required this.size,
  }) : _position = CameraPosition(
          target: LatLng(
            double.parse(model.latitude),
            double.parse(model.longitude),
          ),
          zoom: 14,
        );

  final CameraPosition _position;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: size,
      child: GoogleMap(
        myLocationEnabled: false,
        initialCameraPosition: _position,
        mapType: MapType.hybrid,
        markers: {
          Marker(
            markerId: MarkerId(UniqueKey().toString()),
            position: LatLng(
              double.parse(model.latitude),
              double.parse(model.longitude),
            ),
          ),
        },
      ),
    );
  }
}
