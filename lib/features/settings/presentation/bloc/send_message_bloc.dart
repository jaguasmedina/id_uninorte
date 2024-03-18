import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:identidaddigital/core/domain/entities/entities.dart';
import 'package:identidaddigital/core/error/failures.dart';
import 'package:identidaddigital/core/presentation/bloc/bloc.dart';
import 'package:identidaddigital/features/settings/domain/repositories/settings_repository.dart';

@injectable
class SendMessageBloc extends BaseBloc {
  final SettingsRepository _settingsRepository;

  SendMessageBloc(this._settingsRepository);

  bool validateText(String text) {
    return text != null && text.trim().length >= 3;
  }

  Future<Either<Failure, Unit>> sendMessage(String text, User user) {
    final message = _buildMessage(text, user);
    return _settingsRepository.sendMessage(message);
  }

  Message _buildMessage(String text, User user) {
    final name = user.name;
    final document = user.document;
    final email = user.currentEmail;
    final message = 'ID UNINORTE <br> '
        'Datos del usuario <br> '
        'Nombre: $name <br> '
        'Documento: $document <br> '
        'Correo electrónico: $email <br> '
        '$text';
    return Message(
      sender: user.currentEmail,
      content: message,
    );
  }
}
