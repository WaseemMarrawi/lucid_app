import 'package:restaurants_menu/features/chat/data/model/chat_response.dart';
import 'package:restaurants_menu/features/chat/data/model/voice_response.dart';
import '../../../../common/helper/src/typedef.dart';
import '../../../../core/unified_api/api_variables.dart';
import '../../../../core/unified_api/dio/api_client.dart';
import '../../../../core/unified_api/error/api_handeler_manager.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ChatRemoteData with HandlingApiManager {
  final ApiClient _apiClient;

  ChatRemoteData({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<ChatResponse> sendMessage(BodyMap params) async => wrapHandlingApi(
    tryCall: () => _apiClient.post(
      ApiVariables.sendMessage(),
      data: params,

    ),
    jsonConvert: chatResponseFromJson,
  );
  Future<VoiceResponse> sendVoice(BodyMap params) async => wrapHandlingApi(
    tryCall: () => _apiClient.post(
      ApiVariables.sendMessage(),
      data: params,

    ),
    jsonConvert: voiceResponseFromJson,
  );


}
