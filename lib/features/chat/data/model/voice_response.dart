
VoiceResponse voiceResponseFromJson( str) => VoiceResponse.fromJson(str);


class VoiceResponse {
  final bool? success;
  final String? message;
  final Data? data;

  VoiceResponse({
    this.success,
    this.message,
    this.data,
  });

  VoiceResponse copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      VoiceResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory VoiceResponse.fromJson(Map<String, dynamic> json) => VoiceResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final String? event;
  final String? conversationId;
  final String? answer;

  Data({
    this.event,
    this.conversationId,
    this.answer,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    final rawAnswer = json["answer"]?.toString();

    return Data(
      event: json["event"]?.toString(),
      conversationId: json["conversation_id"]?.toString(),
      answer: _extractUrl(rawAnswer),
    );
  }

  Map<String, dynamic> toJson() => {
    "event": event,
    "conversation_id": conversationId,
    "answer": answer,
  };

  static String? _extractUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final text = value.trim();

    if (text.startsWith('http://') || text.startsWith('https://')) {
      return text;
    }

    final markdownRegex = RegExp(
      r'\[.*?\]\((https?:\/\/[^)]+)\)',
    );

    final match = markdownRegex.firstMatch(text);

    return match?.group(1);
  }
}