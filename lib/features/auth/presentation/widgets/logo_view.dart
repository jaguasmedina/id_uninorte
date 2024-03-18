import 'package:flutter/material.dart';
import 'package:identidaddigital/core/i18n/app_localizations.dart';
import 'package:identidaddigital/core/utils/utils.dart' as utils;

class LogoView extends StatelessWidget {
  const LogoView();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(
          width: 100.0,
          height: 100.0,
          child: Image(
            image: AssetImage(utils.Assets.logoSmall),
          ),
        ),
        const SizedBox(height: 16.0),
        Text(
          localizations.translate('login_logo_label'),
          style: const TextStyle(
            fontSize: 12.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
