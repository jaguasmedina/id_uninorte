import 'package:identidaddigital/core/domain/entities/faq.dart';

class FaqModel extends Faq {
  const FaqModel({
    int? id,
    String? title,
    String? content,
  }) : super(
          id: id ?? 0,
          title: title ?? '',
          content: content ?? '',
        );

  factory FaqModel.fromMap(Map map) {
    return FaqModel(
      id: map['id'],
      title: map['title'],
      content: map['content'],
    );
  }
}
