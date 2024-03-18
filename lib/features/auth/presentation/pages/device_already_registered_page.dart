import 'package:flutter/material.dart';
import 'package:identidaddigital/core/error/failures.dart';
import 'package:identidaddigital/core/i18n/app_localizations.dart';
import 'package:identidaddigital/core/presentation/widgets/widgets.dart';
import 'package:identidaddigital/core/utils/dialog_manager.dart';
import 'package:identidaddigital/core/utils/my_icons.dart';
import 'package:identidaddigital/di/injection.dart';
import 'package:identidaddigital/features/auth/presentation/bloc/login_bloc.dart';
import 'package:identidaddigital/features/settings/presentation/bloc/settings_bloc.dart';

class DeviceAlreadyRegisteredPage extends StatefulWidget {
  /// Un-named route for [DeviceAlreadyRegisteredPage].
  static Route route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => DeviceAlreadyRegisteredPage(),
    );
  }

  @override
  _DeviceAlreadyRegisteredPageState createState() =>
      _DeviceAlreadyRegisteredPageState();
}

class _DeviceAlreadyRegisteredPageState
    extends State<DeviceAlreadyRegisteredPage> {
  final _bloc = sl<SettingsBloc>();
  final _LoginBloc = sl<LoginBloc>();

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

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              MyIcons.multipleDevices,
              color: Theme.of(context).accentColor,
              size: 100.0,
            ),
            const SizedBox(height: 22.0, width: double.infinity),
            Text(
              localizations.translate('device_already_registered_title'),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              localizations.translate('device_already_registered_message'),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 32.0),
            SecondaryButton(
              title: localizations.translate('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            SecondaryButton(
              title: localizations.translate('unlink'),
              onPressed: () async {
                final result = await _bloc.unlinkDevice();
                if (!mounted) return;
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
                      message: localizations
                          .translate('device_unlinked_successfully'),
                      buttonText: localizations.translate('exit'),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return SimpleAppBar(
      title: localizations.translate('back'),
      icon: MyIcons.capture,
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }
}

/*
Su carnet está siendo generado.
En 3-5 días hábiles recibirás un correo de confirmación.

Sólo puedes tener un dispositivo registrado.
Desvincula tu dispositivo actual para poder acceder en este.

Sube una foto para completar tu carnet.
No encontramos una foto para tu carnet en nuestra base de datos.

*/
