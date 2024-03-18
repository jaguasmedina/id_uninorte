import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:identidaddigital/core/enums/enums.dart';
import 'package:identidaddigital/core/error/failures.dart';
import 'package:identidaddigital/core/extensions/size_extension.dart';
import 'package:identidaddigital/core/i18n/app_localizations.dart';
import 'package:identidaddigital/core/presentation/providers/user_provider.dart';
import 'package:identidaddigital/core/presentation/widgets/widgets.dart';
import 'package:identidaddigital/core/navigation/app_navigator.dart';
import 'package:identidaddigital/core/theme/app_theme.dart';
import 'package:identidaddigital/core/utils/utils.dart';
import 'package:identidaddigital/features/faqs/presentation/pages/faqs_page.dart';
import 'package:identidaddigital/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:identidaddigital/features/settings/presentation/pages/change_external_password_settings_page.dart';
import 'package:identidaddigital/features/settings/presentation/pages/send_message_page.dart';
import 'package:identidaddigital/features/settings/presentation/widgets/widgets.dart';
import 'package:identidaddigital/di/injection.dart';

class SettingsPage extends StatefulWidget {
  /// Un-named route for [SettingsPage].
  static Route route() {
    return MaterialPageRoute<dynamic>(builder: (_) => SettingsPage());
  }

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _bloc = sl<SettingsBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.setInitialValues();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  void _closeSession(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Destinations.login, (_) => false);
  }

  void _openSendMessage() {
    Navigator.of(context).push(SendMessagePage.route());
  }

  void _openChangeExternalPassword() {
    Navigator.of(context).push(ChangeExternalPasswordSettingsPage.route());
  }

  void _openFaqs() {
    Navigator.of(context).push(FaqsPage.route());
  }

  Future<void> _showUnlinkDialog(BuildContext context) async {
    final localizations = AppLocalizations.of(context);
    final confirmed = await DialogManager.showAskDialog(
      context: context,
      icon: Icons.error_outline,
      message: localizations.translate('unlink_confirm_question'),
      confirmText: localizations.translate('unlink'),
    );
    if (confirmed) {
      _unlinkDevice(context);
    }
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    final localizations = AppLocalizations.of(context);
    final confirmed = await DialogManager.showAskDialog(
      context: context,
      icon: MyIcons.logout,
      message: localizations.translate('exit_confirm_question'),
      confirmText: localizations.translate('exit'),
    );
    if (confirmed) {
      await _bloc.logout();
      _closeSession(context);
    }
  }

  Future<void> _unlinkDevice(BuildContext context) async {
    final localizations = AppLocalizations.of(context);
    DialogManager.showLoading(context: context);
    final reslut = await _bloc.unlinkDevice();
    if (!mounted) return;
    Navigator.of(context).pop();
    reslut.fold(
      (failure) async {
        if (failure is DeviceAlreadyUnlinkedFailure) {
          await DialogManager.showMessage(
            context: context,
            title: localizations.translate('error_title'),
            message: localizations.translate(failure.key),
          );
          _closeSession(context);
        } else {
          DialogManager.showMessage(
            context: context,
            title: localizations.translate('error_title'),
            message: localizations.translate(failure.key),
          );
        }
      },
      (_) async {
        await DialogManager.showMessage(
          context: context,
          title: localizations.translate('device_unlinked'),
          message: localizations.translate('device_unlinked_successfully'),
          buttonText: localizations.translate('exit'),
        );
        _closeSession(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final localizations = AppLocalizations.of(context);
    final userProvider = Provider.of<UserProvider>(context);
    final shouldShowChangePassword = userProvider.user.emailExt != null;

    return Scaffold(
      appBar: UserAppBar(
        backgroundColor: AppTheme.of(context).secondaryHeaderColor,
        onLeadingPressed: () {
          Navigator.of(context).pop();
        },
        trailing: LabeledView(
          label: localizations.translate('settings_title'),
          position: LabelPosition.left,
          child: const Icon(MyIcons.settings, size: 30.0),
        ),
      ),
      body: BlocBuilder(
        bloc: _bloc,
        builder: (BuildContext context, PageState state) {
          return SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: GridView.count(
                    crossAxisCount: size.isMobile ? 2 : 4,
                    mainAxisSpacing: 34.0,
                    crossAxisSpacing: 8.0,
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 32.0,
                    ),
                    children: <Widget>[
                      if (_bloc.areBiometricsSupported)
                        SwitchIconButton(
                          title: localizations
                              .translate('settings_enable_biometrics'),
                          icon: MyIcons.fingerprint,
                          enabled: _bloc.biometricAccessEnabled,
                          onChanged: (isActive) {
                            _bloc.changeBiometricAccessEnabled(
                                isEnabled: isActive);
                          },
                        ),
                      IconLabelInfo(
                        title:
                            localizations.translate('settings_unlink_device'),
                        icon: MyIcons.deviceClose,
                        label: '',
                        onTap: () => _showUnlinkDialog(context),
                        // onChanged: (isActive) {},
                      ),
                      IconLabelInfo(
                        title: localizations.translate('settings_send_message'),
                        label: '',
                        icon: MyIcons.send,
                        iconPadding: const EdgeInsets.all(16.0),
                        onTap: () => _openSendMessage(),
                      ),
                      if (shouldShowChangePassword)
                        IconLabelInfo(
                          title: localizations.translate('settings_security'),
                          label: localizations
                              .translate('settings_security_label'),
                          icon: MyIcons.password,
                          iconPadding: const EdgeInsets.all(18.0),
                          onTap: () => _openChangeExternalPassword(),
                        ),
                      IconLabelInfo(
                        title: localizations.translate('settings_help'),
                        label: localizations.translate('settings_help_label'),
                        icon: Icons.help_outline,
                        iconPadding: const EdgeInsets.all(16.0),
                        onTap: () => _openFaqs(),
                      ),
                      IconLabelInfo(
                        title: localizations.translate('settings_app_info'),
                        label: 'Versión ${_bloc.appVersion}',
                        icon: MyIcons.info,
                        iconPadding: const EdgeInsets.all(14.0),
                      ),
                    ],
                  ),
                ),
                _ExitButton(
                  onTap: () => _showLogoutDialog(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ExitButton extends StatelessWidget {
  final VoidCallback onTap;

  const _ExitButton({
    Key key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Align(
      alignment: Alignment.centerRight,
      child: NoFeedbackButton(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(MyIcons.logout, size: 40.0),
              const SizedBox(width: 16.0),
              Text(
                localizations.translate('exit'),
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
