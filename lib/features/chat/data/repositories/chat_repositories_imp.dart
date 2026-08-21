import 'package:restaurants_menu/features/chat/data/data_source/chat_remote_data.dart';
import 'package:restaurants_menu/features/chat/data/model/chat_response.dart';
import 'package:restaurants_menu/features/chat/data/model/voice_response.dart';
import '../../../../common/helper/src/typedef.dart';
import '../../../../core/unified_api/error/error_handeler.dart';
import 'package:injectable/injectable.dart';
import '../../domin/repositories/chat_repositories.dart';

@LazySingleton(as: ChatRepositories)
class ChatRepositoriesImp with HandlingException implements ChatRepositories {
  final ChatRemoteData _remoteData;

  ChatRepositoriesImp({required ChatRemoteData remoteData})
      : _remoteData = remoteData;


  @override
  DataResponse<ChatResponse> sendMessage(BodyMap params)async => wrapHandlingException(
    tryCall: () => _remoteData.sendMessage(params),
  );

  @override
  DataResponse<VoiceResponse> voiceMessage(BodyMap params)async => wrapHandlingException(
    tryCall: () => _remoteData.sendVoice(params),
  );

}
