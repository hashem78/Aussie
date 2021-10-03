import 'package:aussie/models/gmap.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AussieGMap extends StatefulWidget {
  final AussieGMapModel model;
  final Size size;
  AussieGMap({Key? key, 
    required this.model,
    required this.size,
  }) : _position = CameraPosition(
          target: LatLng(
            double.parse(model.latitude!),
            double.parse(model.longitude!),
          ),
          zoom: 14,
        ), super(key: key);

  final CameraPosition _position;

  @override
  _AussieGMapState createState() => _AussieGMapState();
}

class _AussieGMapState extends State<AussieGMap>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox.fromSize(
      size: widget.size,
      child: GoogleMap(
        initialCameraPosition: widget._position,
        mapType: MapType.hybrid,
        gestureRecognizers: {}
          ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer())),
        markers: {
          Marker(
            markerId: MarkerId(UniqueKey().toString()),
            position: LatLng(
              double.parse(widget.model.latitude!),
              double.parse(widget.model.longitude!),
            ),
          ),
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
