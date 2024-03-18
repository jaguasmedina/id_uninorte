import 'package:flutter/material.dart';

import 'package:identidaddigital/core/i18n/app_localizations.dart';
import 'package:identidaddigital/core/presentation/widgets/widgets.dart';
import 'package:identidaddigital/core/utils/dialog_manager.dart';
import 'package:identidaddigital/features/auth/presentation/widgets/help_alert.dart';

class HelpRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return NoFeedbackButton(
      onTap: () {
        DialogManager.showMyGeneralDialog<void>(
          context: context,
          builder: (_) => HelpAlert(),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    localizations.translate('login_help'),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const Icon(Icons.help_outline)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
