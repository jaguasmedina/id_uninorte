import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// Página que muestra el código QR en pantalla completa.
///
/// **Cambios realizados para mejorar la usabilidad:**
/// - **Problema identificado**: El código QR en vista completa era muy pequeño
/// - **Solución aplicada**: Aumento del tamaño del QR de 200.0 a 350.0 (+75% más grande)
/// - **Beneficio**: Mejor experiencia de usuario al escanear el código QR
///
/// **Características:**
/// - Tamaño: 350.0 x 350.0 píxeles
/// - Hero animation: Transición fluida desde la tarjeta
/// - Interactividad: Tap para cerrar la vista
/// - Responsive: Se adapta al 76% del ancho de la pantalla

import 'package:identidaddigital/core/presentation/widgets/widgets.dart';
import 'package:identidaddigital/features/digital_card/constants/tags.dart';
import 'package:identidaddigital/features/digital_card/presentation/bloc/digital_card_bloc.dart';

class QrCodeFullPage extends StatelessWidget {
  final String initialData;
  final DigitalCardBloc bloc;

  const QrCodeFullPage({
    Key? key,
    required this.bloc,
    required this.initialData,
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
                  child: QrImageView(
                    data: snapshot.data ?? '',
                    size: 350.0,
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
