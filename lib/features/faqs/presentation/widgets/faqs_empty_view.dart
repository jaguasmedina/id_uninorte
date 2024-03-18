import 'package:flutter/material.dart';
import 'package:identidaddigital/core/i18n/app_localizations.dart';
import 'package:identidaddigital/core/presentation/widgets/widgets.dart';

class FaqsEmptyView extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const FaqsEmptyView({
    Key key,
    @required this.title,
    @required this.subtitle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 8.0),
          Align(
            child: PrimaryButton(
              title: getString(context, 'retry'),
              onPressed: onTap,
            ),
          ),
        ],
      ),
    );
  }
}
