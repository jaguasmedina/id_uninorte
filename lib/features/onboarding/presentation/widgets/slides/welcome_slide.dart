import 'package:flutter/material.dart';
import 'package:identidaddigital/core/utils/utils.dart';
import 'package:identidaddigital/features/onboarding/presentation/widgets/widgets.dart';

class WelcomeSlide extends StatelessWidget {
  const WelcomeSlide();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              _buildLogo(context),
              const SizedBox(height: 8.0),
              _buildTitle(context),
            ],
          ),
          _buildInternalExplanation(context),
          _buildExternalExplanation(context),
        ],
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Hero(
      tag: 'launch-image',
      child: SizedBox(
        width: 136.0,
        height: 136.0,
        child: Image.asset(Assets.launchLogo),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return const Text.rich(
      TextSpan(children: <InlineSpan>[
        TextSpan(text: 'Bienvenido\na '),
        TextSpan(
            text: 'ID Uninorte',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
      ]),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 34.0,
      ),
    );
  }

  Widget _buildInternalExplanation(BuildContext context) {
    return Row(
      children: const <Widget>[
        Expanded(
          flex: 3,
          child: BodyRichText(
            textAlign: TextAlign.end,
            children: [
              TextSpan(text: 'Si tienes cuenta de correo '),
              BoldTextSpan(text: 'Uninorte, '),
              TextSpan(
                text: 'ingresa con tu usuario y clave.',
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Center(
            child: Icon(MyIcons.internalUser, size: 50.0),
          ),
        ),
      ],
    );
  }

  Widget _buildExternalExplanation(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Center(
            child: Icon(
              MyIcons.externalUser,
              size: 50.0,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
        const Expanded(
          flex: 3,
          child: BodyRichText(
            textAlign: TextAlign.start,
            children: [
              TextSpan(text: 'Si eres un '),
              BoldTextSpan(text: 'usuario externo, '),
              TextSpan(
                text:
                    '(contratista, visitante, etc.) ingresa con las instrucciones enviadas por correo.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
