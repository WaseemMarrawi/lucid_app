import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import '../../../extensions/src/context_extensions.dart';
import '../../design.dart';

// class CacheNetworkImage extends StatelessWidget {
//   const  CacheNetworkImage({
//     super.key,
//     this.border,
//     this.borderRadius,
//     this.width,
//     this.height,
//     required this.imageUrl,
//     this.boxFit = BoxFit.cover,
//     this.shape = BoxShape.rectangle,
//     this.blurHash
//   });
//   final double? width;
//   final double? height;
//   final String imageUrl;
//   final BoxFit boxFit;
//   final Border? border;
//   final BoxShape shape;
//   final BorderRadiusGeometry? borderRadius;
//   final String? blurHash;
//   @override
//   Widget build(BuildContext context) {
//
//     if (imageUrl.isEmpty) {
//       return Container(
//         width: width,
//         height: height,
//         decoration: BoxDecoration(
//           shape: shape,
//           border: border,
//           borderRadius: borderRadius,
//           color: Colors.grey[200],
//         ),
//         child: const Icon(Icons.image_not_supported),
//       );
//     }
//
//     return ExtendedImage.network(
//       imageUrl,
//       width: width,
//       height: height,
//       fit: boxFit,
//       cache: true,
//       timeLimit: const Duration(seconds: 10),
//       timeRetry: const Duration(seconds: 10),
//       loadStateChanged: (state) {
//         switch (state.extendedImageLoadState) {
//           case LoadState.loading:
//             return ShimmerWidget(
//               width: width,
//               height: height,
//               shape: shape,
//               border: border,
//               borderRadius: borderRadius,
//             );
//
//           case LoadState.completed:
//             return Container(
//               width: width,
//               height: height,
//               decoration: BoxDecoration(
//                 shape: shape,
//                 border: border,
//                 borderRadius: borderRadius,
//                 image: DecorationImage(
//                   image: state.imageProvider,
//                   fit: boxFit,
//                 ),
//               ),
//             );
//
//           default:
//             return GestureDetector(
//               onTap: state.reLoadImage,
//               child: Container(
//                 width: width,
//                 height: height,
//                 decoration: BoxDecoration(
//                   shape: shape,
//                   border: border,
//                   borderRadius: borderRadius,
//                 ),
//                 child: Center(
//                   child: Icon(
//                     Icons.replay_circle_filled_sharp,
//                     color: context.primarySwatch,
//                     size: width ?? 50,
//                   ),
//                 ),
//               ),
//             );
//         }
//       },
//     );
//   }
// }



import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheNetworkImage extends StatefulWidget {
  const CacheNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.boxFit = BoxFit.cover,
    this.border,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit boxFit;
  final Border? border;
  final BorderRadiusGeometry? borderRadius;
  final BoxShape shape;

  @override
  State<CacheNetworkImage> createState() =>
      _CacheNetworkImageState();
}

class _CacheNetworkImageState
    extends State<CacheNetworkImage> {
  File? cachedFile;

  @override
  void initState() {
    super.initState();
    _loadCache();
  }

  Future<void> _loadCache() async {
    final cache =
    await DefaultCacheManager().getFileFromCache(
      widget.imageUrl,
    );

    if (cache == null) return;

    if (!mounted) return;

    setState(() {
      cachedFile = cache.file;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrl.isEmpty) {
      return const SizedBox();
    }

    if (cachedFile != null) {
      return Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          shape: widget.shape,
          border: widget.border,
          borderRadius: widget.borderRadius,
          image: DecorationImage(
            image: FileImage(cachedFile!),
            fit: widget.boxFit,

          ),
        ),
      );
    }

    return ExtendedImage.network(
      widget.imageUrl,
      cache: true,
      width: widget.width,
      height: widget.height,
      fit: widget.boxFit,
      loadStateChanged: (state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return ShimmerWidget(
              width: widget.width,
              height: widget.height,
              shape: widget.shape,
              border: widget.border,
              borderRadius: widget.borderRadius,
            );

          case LoadState.completed:
            return Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                shape: widget.shape,
                border: widget.border,
                borderRadius: widget.borderRadius,
                image: DecorationImage(
                  image: state.imageProvider,
                  fit: widget.boxFit,

                ),
              ),
            );

          default:
            return Center(
              child: Icon(
                Icons.broken_image_outlined,
                color: context.primarySwatch,
                size: widget.width,
              ),
            );
        }
      },
    );
  }
}
