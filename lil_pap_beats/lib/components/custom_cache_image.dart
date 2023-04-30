import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedImage extends StatelessWidget {
  const CustomCachedImage({
    super.key,
    required this.url,
    this.height,
    this.width,
    this.radius = 0,
  });

  final String url;
  final double? height;
  final double? width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        width: width,
        height: height,
        imageUrl: url,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => Image.asset(
          "assets/images/lilpap.jpeg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
