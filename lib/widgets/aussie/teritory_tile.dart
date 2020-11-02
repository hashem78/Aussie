import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:Aussie/models/teritories/teritory.dart';

class TeritoryTile extends StatelessWidget {
  final TeritoryModel model;
  const TeritoryTile({
    @required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.5),
      child: ListTile(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TeritoryMapScreen(
              model: model,
            ),
          ),
        ),
        tileColor: Colors.green,
        title: Text(
          model.title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        subtitle: Text(
            "Long: ${model.longitude}, Lat: ${model.latitude}, Admin: ${model.admin}"),
      ),
    );
  }
}

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
