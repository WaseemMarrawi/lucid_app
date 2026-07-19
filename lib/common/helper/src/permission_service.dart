//
// import 'package:permission_handler/permission_handler.dart';
//
// class PermissionService {
//   // إنشاء المثيل الوحيد من الخدمة
//   static final PermissionService _instance = PermissionService._internal();
//   factory PermissionService() => _instance;
//   PermissionService._internal();
//
//   /// طلب جميع الأذونات اللازمة للتطبيق
//   Future<Map<Permission, PermissionStatus>> requestAllPermissions() async {
//     List<Permission> permissions = [
//       Permission.camera,
//       Permission.location,
//       Permission.microphone,
//       Permission.storage,
//       // أضف المزيد من الأذونات حسب الحاجة
//     ];
//
//     return await permissions.request();
//   }
//
//   /// التحقق إذا كان الإذن مُعطى، وطلبه إذا لم يُعطى
//   Future<bool> checkAndRequestPermission(Permission permission) async {
//     if (await permission.isGranted) return true;
//
//     PermissionStatus status = await permission.request();
//     if (status.isPermanentlyDenied) {
//       await _showPermissionDeniedDialog(permission);
//     }
//     return status.isGranted;
//   }
//
//   /// التحقق وطلب جميع الأذونات مع إعطاء رسائل مناسبة للمستخدم
//   Future<void> checkAndRequestAllPermissions() async {
//     Map<Permission, PermissionStatus> statuses = await requestAllPermissions();
//     statuses.forEach((permission, status) async {
//       if (status.isDenied || status.isPermanentlyDenied) {
//         await _handlePermissionStatus(permission, status);
//       }
//     });
//   }
//
//   /// التعامل مع حالة الإذن بناءً على حالته
//   Future<void> _handlePermissionStatus(Permission permission, PermissionStatus status) async {
//     if (status.isDenied) {
//       print('${permission.toString()} permission denied');
//       await _showPermissionDeniedDialog(permission);
//     } else if (status.isPermanentlyDenied) {
//       print('${permission.toString()} permission permanently denied');
//       await _showPermissionPermanentlyDeniedDialog(permission);
//     }
//   }
//
//   /// عرض نافذة تنبيه في حالة رفض الإذن بشكل دائم
//   Future<void> _showPermissionPermanentlyDeniedDialog(Permission permission) async {
//     // يمكنك تنفيذ نافذة تنبيه لتوجيه المستخدم إلى الإعدادات
//     // openAppSettings();
//   }
//
//   /// عرض نافذة تنبيه عند رفض الإذن
//   Future<void> _showPermissionDeniedDialog(Permission permission) async {
//     // يمكن إضافة نافذة تنبيه للمستخدم تحثه على الموافقة
//   }
// }
