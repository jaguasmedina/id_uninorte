import 'package:identidaddigital/core/domain/entities/message.dart';

class MessageModel extends Message {
  const MessageModel({
    String sender,
    String content,
  }) : super(
          sender: sender,
          content: content,
        );

  factory MessageModel.fromEntity(Message entity) {
    return MessageModel(
      sender: entity.sender,
      content: entity.content,
    );
  }

  Map<String, String> toMap() {
    return {
      'email': sender,
      'message': content,
    };
  }
}
