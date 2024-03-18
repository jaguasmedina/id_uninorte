import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import 'package:identidaddigital/core/enums/enums.dart';

abstract class BaseBloc {
  final _controller = BehaviorSubject<PageState>();

  /// Page state stream.
  Stream<PageState> get stream => _controller.stream;

  /// Initial page state.
  PageState get initialState => PageState.idle;

  /// Current state.
  PageState get state {
    return _controller.stream.value;
  }

  /// Notify that an object has changed.
  void setState(PageState pageState) {
    if (!_controller.isClosed) {
      _controller.sink.add(pageState);
    }
  }

  /// Close streams.
  @mustCallSuper
  void dispose() {
    _controller.close();
  }
}
