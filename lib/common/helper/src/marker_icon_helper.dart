// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// class MarkerIconHelper {
//   /// Creates a BitmapDescriptor from an asset image with a specified width.
//   static Future<BitmapDescriptor> fromAsset(String assetPath, int width) async {
//     try {
//       ByteData data = await rootBundle.load(assetPath);
//       ui.Codec codec = await ui.instantiateImageCodec(
//         data.buffer.asUint8List(),
//         targetWidth: width,
//       );
//       ui.FrameInfo frameInfo = await codec.getNextFrame();
//       return BitmapDescriptor.fromBytes(
//         (await frameInfo.image.toByteData(format: ui.ImageByteFormat.png))!
//             .buffer
//             .asUint8List(),
//       );
//     } catch (e) {
//       throw Exception("Failed to create BitmapDescriptor: $e");
//     }
//   }
// }