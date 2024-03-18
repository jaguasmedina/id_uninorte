import 'package:equatable/equatable.dart';

class Faq extends Equatable {
  final int id;
  final String title;
  final String content;

  const Faq({
    this.id,
    this.title,
    this.content,
  });

  @override
  List<Object> get props => [id];
}
