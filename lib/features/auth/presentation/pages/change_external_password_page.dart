import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:identidaddigital/core/navigation/app_navigator.dart';
import 'package:identidaddigital/core/i18n/app_localizations.dart';
import 'package:identidaddigital/core/utils/utils.dart';
import 'package:identidaddigital/core/presentation/providers/user_provider.dart';
import 'package:identidaddigital/core/presentation/widgets/widgets.dart';
import 'package:identidaddigital/core/utils/my_icons.dart';
import 'package:identidaddigital/features/auth/presentation/bloc/change_external_password_bloc.dart';
import 'package:identidaddigital/di/injection.dart';

class ChangeExternalPasswordPage extends StatefulWidget {
  /// Anonymous route for [ChangeExternalPasswordPage].
  static Route<void> route() {
    return MaterialPageRoute(builder: (_) => ChangeExternalPasswordPage());
  }

  @override
  _ChangeExternalPasswordPageState createState() =>
      _ChangeExternalPasswordPageState();
}

class _ChangeExternalPasswordPageState
    extends State<ChangeExternalPasswordPage> {
  final _bloc = sl<ChangeExternalPasswordBloc>();
  final _form = GlobalKey<FormState>();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  Future<void> _validateForm() async {
    if (_form.currentState.validate()) {
      _form.currentState.save();
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      _bloc.changeUsername(userProvider.user.emailExt);
      FocusScope.of(context).unfocus();
      await _changePassword();
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
      (r) {
        AppNavigator.navigator.pushNamedAndRemoveUntil(
          Destinations.carnet,
          (route) => false,
        );
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
                  Icon(
                    MyIcons.password,
                    color: Theme.of(context).accentColor,
                    size: 96.0,
                  ),
                  const SizedBox(height: 22.0, width: double.infinity),
                  const Text(
                    'Actualiza tu contraseña',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Por seguridad, por favor establece una nueva contraseña',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    getString(context, 'password_requirements'),
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
                      hintText: 'Nueva contraseña',
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
                    title: 'Guardar',
                    onPressed: () {
                      _validateForm();
                    },
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
    // final localizations = AppLocalizations.of(context);
    return SimpleAppBar(
      title: 'Seguridad',
      icon: MyIcons.password,
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }
}
