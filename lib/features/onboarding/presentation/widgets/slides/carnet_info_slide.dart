import 'package:flutter/material.dart';
import 'package:identidaddigital/core/utils/utils.dart';
import 'package:identidaddigital/features/onboarding/presentation/widgets/widgets.dart';

class CarnetInfoSlide extends StatelessWidget {
  const CarnetInfoSlide();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: const <Widget>[
              SizedBox(
                height: 90.0,
                child: Image(
                  image: AssetImage(Assets.carnetVerified),
                ),
              ),
              SizedBox(height: 8.0),
              BodyRichText(
                children: [
                  TextSpan(text: 'Generación automática\nde '),
                  BoldTextSpan(text: 'tu carnet.'),
                ],
              ),
            ],
          ),
          Column(
            children: const <Widget>[
              SizedBox(
                height: 80.0,
                child: Image(
                  image: AssetImage(Assets.captureTimer),
                ),
              ),
              SizedBox(height: 16.0),
              BodyRichText(
                children: [
                  BoldTextSpan(text: 'Sube tu foto'),
                  TextSpan(text: ' y espera su aprobación.'),
                ],
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.chevron_left,
                    size: 50.0,
                    color: Theme.of(context).accentColor,
                  ),
                  const Icon(Icons.remove, size: 50.0),
                  Icon(
                    Icons.chevron_right,
                    size: 50.0,
                    color: Theme.of(context).accentColor,
                  ),
                ],
              ),
              const SizedBox(height: 14.0),
              const BodyRichText(
                children: [
                  TextSpan(text: 'Conoce todos tus\n'),
                  BoldTextSpan(text: 'perfiles activos.'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
