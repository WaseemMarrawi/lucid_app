import 'dart:io';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';

class SmartCacheImage extends StatelessWidget {
  final String? url;
  final String? localPath;
  final double? width;
  final double? height;
  final BoxFit boxFit;

  const SmartCacheImage({
    super.key,
    this.url,
    this.localPath,
    this.width,
    this.height,
    this.boxFit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    // 🟢 1. لو عندي ملف محلي → استخدمه مباشرة
    if (localPath != null && File(localPath!).existsSync()) {
      return Image.file(
        File(localPath!),
        width: width,
        height: height,
        fit: boxFit,
      );
    }

    // 🔵 2. fallback network + cache
    return ExtendedImage.network(
      url ?? '',
      width: width,
      height: height,
      fit: boxFit,
      cache: true,
      loadStateChanged: (state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return const Center(child: CircularProgressIndicator());

          case LoadState.completed:
            return Image(image: state.imageProvider, fit: boxFit);

          default:
            return Icon(Icons.broken_image, size: width ?? 40);
        }
      },
    );
  }
}