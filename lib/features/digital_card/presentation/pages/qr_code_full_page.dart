import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:identidaddigital/core/presentation/widgets/widgets.dart';
import 'package:identidaddigital/features/digital_card/constants/tags.dart';
import 'package:identidaddigital/features/digital_card/presentation/bloc/digital_card_bloc.dart';

class QrCodeFullPage extends StatelessWidget {
  final String initialData;
  final DigitalCardBloc bloc;

  const QrCodeFullPage({
    Key key,
    @required this.bloc,
    @required this.initialData,
  }) : super(key: key);

  /// Un-named route for [QrCodeFullPage].
  static Route<void> route(DigitalCardBloc bloc, String initialData) {
    return MaterialPageRoute(
      builder: (_) => QrCodeFullPage(
        bloc: bloc,
        initialData: initialData,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    void pop() => Navigator.of(context).pop();

    return Scaffold(
      appBar: UserAppBar(onLeadingPressed: pop),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.76,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: pop,
            child: StreamBuilder<String>(
              stream: bloc.qrStream,
              initialData: initialData,
              builder: (context, snapshot) {
                return Hero(
                  tag: kQrCodeHeroTag,
                  child: QrImage(
                    data: snapshot.data,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
