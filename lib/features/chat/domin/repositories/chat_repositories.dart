
import 'package:restaurants_menu/common/helper/helper.dart';
import 'package:restaurants_menu/features/chat/data/model/chat_response.dart';

abstract class ChatRepositories {

  DataResponse<ChatResponse> sendMessage(BodyMap params);
}