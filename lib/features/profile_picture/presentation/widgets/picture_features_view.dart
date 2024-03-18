import 'package:flutter/material.dart';

import 'package:identidaddigital/core/i18n/app_localizations.dart';

class PictureFeaturesView extends StatelessWidget {
  final double widthFactor;

  const PictureFeaturesView({
    Key key,
    this.widthFactor = 0.7,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(getString(context, 'picture_features_title')),
          const SizedBox(height: 8.0),
          _FeatureText(getString(context, 'picture_feature_1')),
          _FeatureText(getString(context, 'picture_feature_2')),
          _FeatureText(getString(context, 'picture_feature_3')),
        ],
      ),
    );
  }
}

class _FeatureText extends StatelessWidget {
  final String text;
  const _FeatureText(
    this.text, {
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Text.rich(
        TextSpan(
          children: <InlineSpan>[
            const WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Padding(
                padding: EdgeInsets.only(right: 4.0),
                child: Icon(Icons.brightness_1, size: 6.0),
              ),
            ),
            TextSpan(text: text),
          ],
        ),
      ),
    );
  }
}
