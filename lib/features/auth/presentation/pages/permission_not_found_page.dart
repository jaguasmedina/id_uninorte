import 'package:flutter/material.dart';

import 'package:identidaddigital/core/i18n/app_localizations.dart';
import 'package:identidaddigital/core/presentation/widgets/widgets.dart';
import 'package:identidaddigital/core/utils/my_icons.dart';

class PermissionNotFoundPage extends StatefulWidget {
  /// Un-named route for [PermissionNotFoundPage].
  static Route route() {
    return MaterialPageRoute<dynamic>(builder: (_) => PermissionNotFoundPage());
  }

  @override
  _PermissionNotFoundPageState createState() => _PermissionNotFoundPageState();
}

class _PermissionNotFoundPageState extends State<PermissionNotFoundPage> {
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: SimpleAppBar(
        title: localizations.translate('back'),
        icon: MyIcons.capture,
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              MyIcons.carnet,
              color: Theme.of(context).accentColor,
              size: 100.0,
            ),
            const SizedBox(height: 22.0),
            Text(
              localizations.translate('permission_not_found_title'),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16.0, width: double.infinity),
            Text(
              localizations.translate('permission_not_found_message'),
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
          ],
        ),
      ),
    );
  }
}
