import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
                child: QrImage(
                  data: 'Hola',
                ),
              ),
              const SizedBox(height: 24.0),
              const BodyRichText(
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
