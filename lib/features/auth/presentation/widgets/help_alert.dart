import 'package:flutter/material.dart';
import 'package:identidaddigital/core/i18n/app_localizations.dart';
import 'package:identidaddigital/core/presentation/widgets/dialogs/constrained_dialog.dart';
import 'package:identidaddigital/core/presentation/widgets/widgets.dart';

class HelpAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
      ),
      content: ConstrainedDialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.help_outline,
              size: 40.0,
            ),
            const SizedBox(height: 8.0),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: localizations.translate('login_help_alert')),
                  const TextSpan(
                    text: ' carnetizacion@uninorte.edu.co.',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              style: theme.textTheme.bodyText2.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            PrimaryButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              title: localizations.translate('ok'),
            )
          ],
        ),
      ),
    );
  }
}
