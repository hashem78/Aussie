import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class AussiePhotoView extends StatelessWidget {
  final String? url;
  const AussiePhotoView({
    Key? key,
    this.url,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: const BottomAppBar(),
      body: PhotoView(
        minScale: PhotoViewComputedScale.contained,
        maxScale: 1.0,
        imageProvider: CachedNetworkImageProvider(url!),
      ),
    );
  }
}
