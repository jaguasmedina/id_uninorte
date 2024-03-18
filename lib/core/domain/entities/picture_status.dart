import 'package:equatable/equatable.dart';

class PictureStatus extends Equatable {
  final String _status;
  final String _message;

  const PictureStatus(this._status, this._message);

  @override
  List<Object> get props => [_status, _message];

  bool get isEmpty {
    if (_status != null) {
      return _status.isEmpty;
    }
    return true;
  }

  bool get isPending => _status == 'Pendiente';

  bool get isRejected => _status == 'Rechazada';

  String get message {
    if (isPending) {
      return 'Tienes una solicitud pendiente. Espera 1 día hábil para su aprobación.';
    } else if (isRejected) {
      return 'Tu última solicitud de cambio de foto fue rechazada. Te agradecemos enviar una nueva foto con las características adecuadas.';
    } else {
      return '';
    }
  }

  @override
  String toString() {
    return _status;
  }
}

class EmptyPictureStatus extends PictureStatus {
  const EmptyPictureStatus() : super(null, null);
}

class PendingPictureStatus extends PictureStatus {
  const PendingPictureStatus() : super('Pendiente', '');
}
