// import 'dart:convert';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:injectable/injectable.dart';
//
// @lazySingleton
// class ImageProviderHelper {
//   final ImagePicker picker = ImagePicker();
//
//   /// Pick multiple images from the gallery
//   Future<List<File>?> pickMultipleImagesFromGallery() async {
//     try {
//       final List<XFile>? images = await picker.pickMultiImage();
//       if (images == null || images.isEmpty) return null;
//
//       // Convert the list of XFile to a list of File
//       List<File> files = images.map((xfile) => File(xfile.path)).toList();
//       return files;
//     } catch (e) {
//       print('Error picking multiple images from gallery: $e');
//       return null;
//     }
//   }
//
//   /// Pick image from the camera (single image)
//   Future<File?> pickImageFromCamera() async {
//     try {
//       final XFile? photo = await picker.pickImage(source: ImageSource.camera);
//       if (photo == null) return null;
//
//       File file = File(photo.path);
//       print('File picked from camera: ${file.path}');
//       return file;
//     } catch (e) {
//       print('Error picking image from camera: $e');
//       return null;
//     }
//   }
//
//   Future<File?> pickImageFromGallery() async {
//     try {
//       final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
//       if (photo == null) return null;
//
//       File file = File(photo.path);
//       print('File picked from camera: ${file.path}');
//       return file;
//     } catch (e) {
//       print('Error picking image from camera: $e');
//       return null;
//     }
//   }
//
//   /// Pick video from the camera (single video)
//   Future<File?> pickVideoFromCamera() async {
//     try {
//       final XFile? video = await picker.pickVideo(source: ImageSource.camera);
//       if (video == null) return null;
//
//       File file = File(video.path);
//       print('Video picked from camera: ${file.path}');
//       return file;
//     } catch (e) {
//       print('Error picking video from camera: $e');
//       return null;
//     }
//   }
//
//   /// Convert picked files to base64 format
//   Future<List<String>?> filesToBase64(List<File>? files) async {
//     if (files == null || files.isEmpty) return null;
//
//     try {
//       List<String> base64Images = [];
//       for (File file in files) {
//         final bytes = await file.readAsBytes();
//         base64Images.add(base64Encode(bytes));
//       }
//       return base64Images;
//     } catch (e) {
//       print('Error converting files to base64: $e');
//       return null;
//     }
//   }
// }
