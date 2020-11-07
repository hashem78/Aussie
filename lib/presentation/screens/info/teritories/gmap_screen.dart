import 'dart:async';

import 'package:Aussie/models/paginated/teritories/teritory.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TeritoryMapScreen extends StatefulWidget {
  final TeritoryModel model;
  const TeritoryMapScreen({@required this.model});
  @override
  _TeritoryMapScreenState createState() => _TeritoryMapScreenState();
}

class _TeritoryMapScreenState extends State<TeritoryMapScreen> {
  CameraPosition _position;
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    _position = CameraPosition(
      target: LatLng(widget.model.latitude, widget.model.longitude),
      zoom: 14.4746,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          widget.model.title,
          style: TextStyle(
            color: Colors.amber,
            fontWeight: FontWeight.w900,
            fontSize: 30,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: GoogleMap(
        initialCameraPosition: _position,
        mapType: MapType.hybrid,
        markers: {
          Marker(
            markerId: MarkerId(UniqueKey().toString()),
            position: LatLng(widget.model.latitude, widget.model.longitude),
          ),
        },
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
