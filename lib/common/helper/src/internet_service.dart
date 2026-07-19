
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

@lazySingleton
class InternetService {
  final InternetConnection _internetConnection;

  InternetService()
      : _internetConnection = InternetConnection();

  /// ترجع true إذا يوجد اتصال بالإنترنت
  Future<bool> hasInternetConnection() async {
    return await _internetConnection.hasInternetAccess;
  }
}