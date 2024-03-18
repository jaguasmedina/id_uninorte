import 'package:flutter/material.dart';

import 'package:identidaddigital/core/i18n/app_localizations.dart';
import 'package:identidaddigital/core/presentation/widgets/dialogs/constrained_dialog.dart';
import 'package:identidaddigital/core/presentation/widgets/secondary_button.dart';
import 'package:identidaddigital/core/presentation/widgets/widgets.dart';

class ActionDialog extends StatelessWidget {
  final IconData icon;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirmed;
  final VoidCallback onCanceled;

  const ActionDialog({
    @required this.message,
    this.confirmText,
    this.cancelText,
    this.onConfirmed,
    this.onCanceled,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
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
          children: <Widget>[
            if (icon != null) _buildIcon(context),
            _buildMessage(context),
            _buildSeparator(),
            _buildButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Icon(
        icon,
        size: 40.0,
        color: Theme.of(context).accentColor,
      ),
    );
  }

  Widget _buildMessage(BuildContext context) {
    return Text(
      message,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyText2.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
          ),
    );
  }

  Widget _buildButton(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Row(
      children: <Widget>[
        Expanded(
          child: SecondaryButton(
            title: cancelText ?? localizations.translate('cancel'),
            onPressed: onCanceled,
          ),
        ),
        const SizedBox(width: 32.0),
        Expanded(
          child: PrimaryButton(
            title: confirmText ?? localizations.translate('accept'),
            onPressed: onConfirmed,
          ),
        ),
      ],
    );
  }

  Widget _buildSeparator() {
    return const SizedBox(height: 16.0);
  }
}
