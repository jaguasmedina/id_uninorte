import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:identidaddigital/core/i18n/app_localizations.dart';
import 'package:identidaddigital/core/presentation/providers/user_provider.dart';
import 'package:identidaddigital/core/presentation/widgets/widgets.dart';
import 'package:identidaddigital/core/theme/app_theme.dart';
import 'package:identidaddigital/core/utils/utils.dart';
import 'package:identidaddigital/features/settings/presentation/bloc/send_message_bloc.dart';
import 'package:identidaddigital/di/injection.dart';

class SendMessagePage extends StatefulWidget {
  /// Anonymous route for [SendMessagePage].
  static Route<void> route() {
    return MaterialPageRoute(builder: (_) => SendMessagePage());
  }

  @override
  _SendMessagePageState createState() => _SendMessagePageState();
}

class _SendMessagePageState extends State<SendMessagePage> {
  final _bloc = sl<SendMessageBloc>();
  final _textController = TextEditingController();
  String _errorText;

  @override
  void dispose() {
    _bloc.dispose();
    _textController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final text = _textController.text;
    if (_bloc.validateText(text)) {
      _errorText = null;
      setState(() {});
      FocusScope.of(context).unfocus();
      final localizations = AppLocalizations.of(context);
      final user = Provider.of<UserProvider>(context, listen: false).user;
      DialogManager.showLoading(context: context);
      final result = await _bloc.sendMessage(text, user);
      if (!mounted) return;
      Navigator.of(context).pop();
      result.fold(
        (failure) {
          DialogManager.showMessage(
            context: context,
            title: localizations.translate('error_title'),
            message: localizations.translate(failure.key),
          );
        },
        (_) async {
          await DialogManager.showMessage(
            context: context,
            title: localizations.translate('send_message_success_title'),
            message: localizations.translate('send_message_success_body'),
          );
          Navigator.of(context).pop();
        },
      );
    } else {
      _errorText = getString(context, 'send_message_validation_error');
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: UserAppBar(
        backgroundColor: AppTheme.of(context).secondaryHeaderColor,
        onLeadingPressed: () => Navigator.of(context).pop(),
        trailing: LabeledView(
          label: localizations.translate('settings_title'),
          position: LabelPosition.left,
          child: const Icon(MyIcons.settings, size: 30.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(MyIcons.send, size: 60.0),
            const SizedBox(height: 8.0, width: double.infinity),
            Text(
              localizations.translate('send_message_title'),
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 24.0),
            Flexible(
              child: ConstrainedBox(
                constraints: BoxConstraints.loose(
                  const Size(400.0, 170.0),
                ),
                child: OutlineTextFormField(
                  expands: true,
                  maxLines: null,
                  hintMaxLines: 3,
                  maxLength: 500,
                  controller: _textController,
                  textAlignVertical: TextAlignVertical.top,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.multiline,
                  hintText: localizations.translate('send_message_hint'),
                  errorText: _errorText,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            SecondaryButton(
              title: localizations.translate('send_message_button'),
              onPressed: () => _sendMessage(),
            ),
          ],
        ),
      ),
    );
  }
}
