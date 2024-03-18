import 'package:flutter/material.dart';

import 'package:identidaddigital/core/i18n/app_localizations.dart';
import 'package:identidaddigital/core/presentation/widgets/dialogs/constrained_dialog.dart';
import 'package:identidaddigital/core/presentation/widgets/primary_button.dart';

class AlertMessage extends StatelessWidget {
  /// Title of the dialog
  final String title;

  /// Message of the dialog
  final String message;

  /// Title of the dialog button
  final String buttonText;

  /// Called when the button is pressed
  final Function onPressed;

  const AlertMessage({
    @required this.onPressed,
    this.title,
    this.message,
    this.buttonText,
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
          children: _buildChildren(context),
        ),
      ),
    );
  }

  List<Widget> _buildChildren(BuildContext context) {
    final children = <Widget>[];
    if (title != null) {
      children.add(_buildTitle(context));
      children.add(_buildSeparator());
    }
    if (message != null) {
      children.add(_buildMessage(context));
      children.add(_buildSeparator());
    }
    children.add(_buildButton(context));
    return children;
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyText2.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
          ),
    );
  }

  Widget _buildMessage(BuildContext context) {
    return Text(
      message,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyText2.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
    );
  }

  Widget _buildButton(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return PrimaryButton(
      onPressed: onPressed,
      title: buttonText ?? localizations.translate('ok'),
    );
  }

  Widget _buildSeparator() {
    return const SizedBox(height: 16.0);
  }
}
