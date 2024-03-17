import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart' show CupertinoActivityIndicator;
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;

  final double? height;
  final double? width;

  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          // color: ConstantColor.kPrimary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.contain,
            alignment: Alignment.topCenter,
          ),
        ),
      ),
      progressIndicatorBuilder: (context, url, progress) => SizedBox(
        height: height,
        width: width,
        child: const Center(
          child: CupertinoActivityIndicator(),
        ),
      ),
      errorWidget: (context, url, error) => SizedBox(
        height: height,
        width: width,
        child: const Icon(Icons.error),
      ),
    );
  }
}
