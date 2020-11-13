import 'package:aussie/models/gmap.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AussieGMapScreen extends StatefulWidget {
  final AussieGMapModel model;
  final Size size;
  const AussieGMapScreen({
    @required this.model,
    @required this.size,
  });
  @override
  _AussieGMapScreenState createState() => _AussieGMapScreenState();
}

class _AussieGMapScreenState extends State<AussieGMapScreen> {
  CameraPosition _position;

  @override
  void initState() {
    _position = CameraPosition(
      target: LatLng(
        double.parse(widget.model.latitude),
        double.parse(widget.model.longitude),
      ),
      zoom: 14,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: widget.size,
      child: GoogleMap(
        myLocationEnabled: false,
        initialCameraPosition: _position,
        mapType: MapType.hybrid,
        markers: {
          Marker(
            markerId: MarkerId(UniqueKey().toString()),
            position: LatLng(
              double.parse(widget.model.latitude),
              double.parse(widget.model.longitude),
            ),
          ),
        },
      ),
    );
  }
}
