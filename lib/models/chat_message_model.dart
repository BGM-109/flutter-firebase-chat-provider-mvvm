class ChatMessageModel {
  final String idFrom;
  final String idTo;
  final String timestamp;
  final String content;
  final int type;

  ChatMessageModel(
      {required this.idFrom,
      required this.idTo,
      required this.timestamp,
      required this.content,
      required this.type});

  Map<String, Object?> toJson() {
    return {
      'idFrom': idFrom,
      'idTo': idTo,
      'timestamp': timestamp,
      'content': content,
      'type': type,
    };
  }
}
