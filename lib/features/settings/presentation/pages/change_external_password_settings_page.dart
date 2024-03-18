import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:identidaddigital/core/i18n/app_localizations.dart';
import 'package:identidaddigital/core/utils/utils.dart';
import 'package:identidaddigital/core/presentation/providers/user_provider.dart';
import 'package:identidaddigital/core/presentation/widgets/widgets.dart';
import 'package:identidaddigital/core/utils/my_icons.dart';
import 'package:identidaddigital/core/theme/app_theme.dart';
import 'package:identidaddigital/features/auth/presentation/bloc/change_external_password_bloc.dart';
import 'package:identidaddigital/di/injection.dart';

class ChangeExternalPasswordSettingsPage extends StatefulWidget {
  /// Un-named route for [ChangeExternalPasswordSettingsPage].
  static Route<void> route() {
    return MaterialPageRoute(
      builder: (_) => ChangeExternalPasswordSettingsPage(),
    );
  }

  @override
  _ChangeExternalPasswordSettingsPageState createState() =>
      _ChangeExternalPasswordSettingsPageState();
}

class _ChangeExternalPasswordSettingsPageState
    extends State<ChangeExternalPasswordSettingsPage> {
  final _bloc = sl<ChangeExternalPasswordBloc>();
  final _form = GlobalKey<FormState>();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  Future<void> _validateForm() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.user.emailExt == null) {
      await DialogManager.showMessage(
        context: context,
        title: getString(context, 'change_external_password_error_title'),
        message: getString(context, 'change_external_password_error_subtitle'),
      );
      Navigator.of(context).pop();
    } else {
      if (_form.currentState.validate()) {
        _form.currentState.save();
        _bloc.changeUsername(userProvider.user.emailExt);
        FocusScope.of(context).unfocus();
        await _changePassword();
      }
    }
  }

  Future<void> _changePassword() async {
    final localizations = AppLocalizations.of(context);
    DialogManager.showLoading(context: context);
    final result = await _bloc.changePasswordForExternalUser();
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
          title:
              localizations.translate('change_external_password_success_title'),
          message: localizations
              .translate('change_external_password_success_subtitle'),
        );
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final localizations = AppLocalizations.of(context);
    const appBarHeight = 62.0;
    final verticalPadding = mediaQuery.viewPadding.vertical;
    final contentHeight =
        mediaQuery.size.height - verticalPadding - appBarHeight;

    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SizedBox(
          height: contentHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Form(
              key: _form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(MyIcons.password, size: 96.0),
                  const SizedBox(height: 22.0, width: double.infinity),
                  Text(
                    localizations.translate('change_external_password_title'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    localizations
                        .translate('change_external_password_subtitle'),
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    localizations.translate('password_requirements'),
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  FractionallySizedBox(
                    widthFactor: 0.84,
                    child: OutlineTextFormField(
                      hintText: localizations
                          .translate('change_external_password_hint'),
                      obscureText: true,
                      inputFormatters: [WhiteSpaceTextInputFormatter()],
                      validator: (value) {
                        final result =
                            FormValidators.validatePasswordPattern(value);
                        if (result == null) return result;
                        return localizations.translate(result);
                      },
                      onSaved: _bloc.changePassword,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  SecondaryButton(
                    title: getString(context, 'save'),
                    onPressed: () => _validateForm(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return UserAppBar(
      backgroundColor: AppTheme.of(context).secondaryHeaderColor,
      onLeadingPressed: () => Navigator.of(context).pop(),
      trailing: LabeledView(
        label: getString(context, 'settings_title'),
        position: LabelPosition.left,
        child: const Icon(MyIcons.settings, size: 30.0),
      ),
    );
  }
}
