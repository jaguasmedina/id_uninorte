import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String sender;
  final String content;

  const Message({
    this.sender,
    this.content,
  });

  @override
  List<Object> get props => [sender, content];
}
