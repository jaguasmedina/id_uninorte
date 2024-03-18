import 'package:flutter/material.dart';

import 'package:identidaddigital/core/i18n/app_localizations.dart';
import 'package:identidaddigital/core/presentation/widgets/widgets.dart';
import 'package:identidaddigital/core/utils/my_icons.dart';
import 'package:identidaddigital/features/onboarding/presentation/widgets/widgets.dart';

class ConfigurationSlide extends StatelessWidget {
  final VoidCallback onStart;

  const ConfigurationSlide({
    Key key,
    this.onStart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 16.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: const <Widget>[
                    Icon(MyIcons.settings, size: 34.0),
                    SizedBox(height: 14.0),
                    BodyText('Configuración de la app'),
                  ],
                ),
                const Icon(MyIcons.fingerprint, size: 94.0),
                const BodyRichText(
                  children: [
                    TextSpan(text: 'Activa el acceso con '),
                    BoldTextSpan(text: 'biometría'),
                    TextSpan(text: '\npara un ingreso fácil y seguro.'),
                  ],
                ),
                const Icon(MyIcons.deviceClose, size: 94.0),
                const BodyRichText(
                  children: [
                    BoldTextSpan(text: 'Desvincula'),
                    TextSpan(
                      text:
                          ' tu dispositivo en cualquier momento. Sólo puedes tener un dispositivo vinculado al tiempo.',
                    ),
                  ],
                ),
              ],
            ),
          ),
          _buildButton(context),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return CustomOutlinedButton(
      onPressed: onStart,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            localizations.translate('start').toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(width: 8.0),
          const Icon(Icons.arrow_forward),
        ],
      ),
    );
  }
}
