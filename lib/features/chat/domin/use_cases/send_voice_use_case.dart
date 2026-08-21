import 'package:injectable/injectable.dart';
import 'package:restaurants_menu/common/helper/helper.dart';
import 'package:restaurants_menu/features/chat/domin/repositories/chat_repositories.dart';
import '../../../../core/use_case/use_case.dart';
import '../../data/model/voice_response.dart';


@lazySingleton
class SendVoiceUseCase implements UseCase<VoiceResponse, SendVoiceParams> {
  final ChatRepositories _repositories;

  SendVoiceUseCase({required ChatRepositories repositories})
      : _repositories = repositories;

  @override
  DataResponse<VoiceResponse> call(SendVoiceParams params) async =>
      await _repositories.voiceMessage(params.getBody());
}

class SendVoiceParams with Params {
  final String message;


  SendVoiceParams({required this.message});

  @override
  BodyMap getBody() {
    return {
      "chat_mode": "audio",
      "query": message,
      // "table_number": "5",
      "customer_dialect": "?????",
      "response_mode": "blocking",
      "conversation_id": ""
    }..removeWhere((key, value) => value == null || value == ''||value=='null');
  }
}
