import 'package:flutter/material.dart';
import 'package:identidaddigital/core/error/failures.dart';
import 'package:identidaddigital/core/utils/utils.dart';
import 'package:identidaddigital/di/injection.dart';
import 'package:identidaddigital/features/auth/presentation/widgets/widgets.dart';
import 'package:identidaddigital/features/faqs/presentation/pages/externals_faqs_page.dart';
import 'package:identidaddigital/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:provider/provider.dart';

import 'package:identidaddigital/core/i18n/app_localizations.dart';
import 'package:identidaddigital/features/auth/presentation/bloc/login_bloc.dart';
import 'package:identidaddigital/features/auth/presentation/widgets/footer_item.dart';

class Footer extends StatelessWidget {
  final _bloc = sl<SettingsBloc>();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final bloc = Provider.of<LoginBloc>(context);

    void _openFaqs() {
      Navigator.of(context).push(ExternalsFaqsPage.route());
    }

    Future<void> _unlinkDevice(BuildContext context) async {
      final localizations = AppLocalizations.of(context);
      DialogManager.showLoading(context: context);
      final result = await _bloc.unlinkDevice();
      Navigator.of(context).pop();
      result.fold(
        (failure) async {
          if (failure is DeviceAlreadyUnlinkedFailure) {
            await DialogManager.showMessage(
              context: context,
              title: localizations.translate('error_title'),
              message: localizations.translate(failure.key),
            );
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
        },
      );
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  FooterItem(
                    text: localizations.translate('settings_help'),
                    onTap: () => _openFaqs(),
                  ),
                ],
              ),
              FooterItem(
                text: localizations.translate('login_privacy_policies'),
                onTap: bloc.launchPrivacyPolicies,
              ),
            ],
          ),
          // const SizedBox(width: 20.0),
          // FooterItem(
          //   text: localizations.translate('login_terms_of_service'),
          //   onTap: bloc.launchPrivacyPolicies,
          // ),
          // const SizedBox(width: 20.0),
          // FooterItem(
          //   text: localizations.translate('login_card_manual'),
          //   onTap: bloc.launchPrivacyPolicies,
          // ),
        ],
      ),
    );
  }
}
