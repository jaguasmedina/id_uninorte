import 'package:flutter/material.dart';

import 'package:identidaddigital/core/constants/constants.dart';
import 'package:identidaddigital/core/i18n/app_localizations.dart';
import 'package:identidaddigital/core/presentation/widgets/widgets.dart';
import 'package:identidaddigital/core/utils/app_market.dart';

class UpdateRequiredPage extends StatelessWidget {
  const UpdateRequiredPage({Key key}) : super(key: key);

  /// Anonymous route for [UpdateRequiredPage].
  static Route<void> route() {
    return MaterialPageRoute(builder: (_) => const UpdateRequiredPage());
  }

  @override
  Widget build(BuildContext context) {
    return DayNightAnnotatedRegion(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints.loose(const Size.fromWidth(440)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.update_rounded,
                      color: Theme.of(context).accentColor,
                      size: 100.0,
                    ),
                    const SizedBox(height: 22.0, width: double.infinity),
                    Text(
                      getString(context, 'app_update_required_title'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      getString(context, 'app_update_required_reason'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    PrimaryButton(
                      title: getString(context, 'update'),
                      onPressed: _openAppMarket,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openAppMarket() {
    openAppMarketFor(
      androidId: kPlayStoreAppId,
      iOSId: kAppleAppId,
    );
  }
}
