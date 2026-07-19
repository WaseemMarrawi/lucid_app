import 'package:injectable/injectable.dart';
import 'package:restaurants_menu/features/chat/data/model/chat_response.dart';
import 'package:restaurants_menu/features/chat/domin/repositories/chat_repositories.dart';
import '../../../../common/helper/src/typedef.dart';
import '../../../../core/use_case/use_case.dart';


@lazySingleton
class SendMessageUseCase implements UseCase<ChatResponse, SendMessageParams> {
  final ChatRepositories _repositories;

  SendMessageUseCase({required ChatRepositories repositories})
      : _repositories = repositories;

  @override
  DataResponse<ChatResponse> call(SendMessageParams params) async =>
      await _repositories.sendMessage(params.getBody());
}

class SendMessageParams with Params {
  final String message;


  SendMessageParams({required this.message});

  @override
  BodyMap getBody() {
    return {
      'message':message,

    }..removeWhere((key, value) => value == null || value == ''||value=='null');
  }
}
