import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageNetworkWidget extends StatelessWidget {
  const ImageNetworkWidget({required this.imageUrl, required this.size, super.key});
  final String imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: size,
      height: size,
      memCacheWidth: (size*2).toInt(),
      memCacheHeight: (size*2).toInt(),

      placeholder: (_, __) => SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),

      errorWidget: (_, __, ___)
      {

        return Icon(Icons.image_not_supported, size: size);}
    );
  }
}
