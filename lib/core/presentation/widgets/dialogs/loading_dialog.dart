import 'package:flutter/material.dart';

import 'package:identidaddigital/core/i18n/app_localizations.dart';
import 'package:identidaddigital/core/utils/utils.dart' as utils;
import 'package:identidaddigital/core/presentation/widgets/dialogs/constrained_dialog.dart';

class LoadingDialog extends StatelessWidget {
  final String title;

  const LoadingDialog({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 20.0,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      contentTextStyle: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 14.0,
        fontFamily: utils.Fonts.primaryFont,
        color: Colors.black,
      ),
      content: ConstrainedDialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              width: 50.0,
              height: 50.0,
              child: CircularProgressIndicator(
                strokeWidth: 2.3,
              ),
            ),
            const SizedBox(height: 26.0),
            Text(
              title ?? localizations.translate('loading'),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
