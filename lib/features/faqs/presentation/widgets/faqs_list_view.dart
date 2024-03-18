import 'package:flutter/material.dart';
import 'package:identidaddigital/core/domain/entities/faq.dart';
import 'package:identidaddigital/core/i18n/app_localizations.dart';
import 'package:identidaddigital/features/faqs/presentation/widgets/faq_item_view.dart';
import 'package:identidaddigital/features/faqs/presentation/widgets/faqs_empty_view.dart';

class FaqsListView extends StatelessWidget {
  final List<Faq> faqs;
  final VoidCallback onRetry;

  const FaqsListView({
    Key key,
    @required this.faqs,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (faqs != null && faqs.isNotEmpty) {
      return ListView.builder(
        padding: const EdgeInsets.only(bottom: 24.0),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          final faq = faqs[index];
          return FaqItemView(faq);
        },
      );
    } else {
      return FaqsEmptyView(
        title: getString(context, 'faqs_empty_title'),
        subtitle: getString(context, 'faqs_empty_subtitle'),
        onTap: onRetry,
      );
    }
  }
}
