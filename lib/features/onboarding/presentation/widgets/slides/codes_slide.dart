import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// Slide de onboarding que muestra ejemplos de códigos de barras y QR.
///
/// **Cambios realizados para mejorar la consistencia:**
/// - **Problema identificado**: El código QR en el slide no tenía tamaño especificado
/// - **Solución aplicada**: Especificación del tamaño del QR a 120.0 píxeles
/// - **Beneficio**: Consistencia visual con otros QR en la aplicación
///
/// **Características:**
/// - Tamaño QR: 120.0 x 120.0 píxeles
/// - Responsive: Se adapta al 36% del ancho de la pantalla
/// - Contenido: Ejemplo de código de barras y QR para demostración

import 'package:identidaddigital/features/onboarding/presentation/widgets/widgets.dart';

class CodesSlide extends StatelessWidget {
  const CodesSlide();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              FractionallySizedBox(
                widthFactor: 0.65,
                child: SizedBox(
                  height: 60.0,
                  child: BarcodeWidget(
                    barcode: Barcode.code128(),
                    data: '100',
                    drawText: false,
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              const BodyRichText(
                key: Key('codes_slide_1'),
                children: [
                  TextSpan(
                    text:
                        'Accede a los diferentes servicios que te ofrece la universidad con tu ',
                  ),
                  BoldTextSpan(
                    text: 'código de barras.',
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: <Widget>[
              FractionallySizedBox(
                widthFactor: 0.36,
                child: QrImageView(
                  data: 'Hola',
                  size: 120.0,
                ),
              ),
              const SizedBox(height: 24.0),
              const BodyRichText(
                key: Key('codes_slide_2'),
                children: [
                  TextSpan(text: 'Utiliza tu '),
                  BoldTextSpan(text: 'código QR'),
                  TextSpan(
                    text:
                        ' para ingresar al campus y oficinas que cuenten con control de acceso.',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
