import 'package:flutter/material.dart';

import 'package:identidaddigital/core/enums/page_state.dart';
import 'package:identidaddigital/core/i18n/app_localizations.dart';
import 'package:identidaddigital/core/presentation/widgets/widgets.dart';
import 'package:identidaddigital/di/injection.dart';
import 'package:identidaddigital/features/faqs/presentation/bloc/faqs_bloc.dart';
import 'package:identidaddigital/features/faqs/presentation/widgets/faqs_empty_view.dart';
import 'package:identidaddigital/features/faqs/presentation/widgets/faqs_list_view.dart';

class ExternalsFaqsPage extends StatefulWidget {
  /// Anonymous route for [ExternalsFaqsPage].
  static Route<void> route() {
    return MaterialPageRoute(builder: (_) => ExternalsFaqsPage());
  }

  @override
  _ExternalsFaqsPageState createState() => _ExternalsFaqsPageState();
}

class _ExternalsFaqsPageState extends State<ExternalsFaqsPage> {
  final _bloc = sl<FaqsBloc>();

  @override
  void initState() {
    super.initState();
    requestFaqs();
  }

  void requestFaqs() {
    _bloc.requestExternalFaqs();
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
      appBar: SimpleAppBar(
        title: localizations.translate('settings_help'),
        icon: Icons.arrow_back,
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
      body: SafeArea(
        child: BlocBuilder(
          bloc: _bloc,
          builder: (context, state) {
            if (state == PageState.busy) {
              return const Center(
                child: CircularProgressIndicator(strokeWidth: 2.3),
              );
            } else if (state == PageState.error && _bloc.failure != null) {
              return FaqsEmptyView(
                title: getString(context, 'error_title'),
                subtitle: getString(context, _bloc.failure.key),
                onTap: () => requestFaqs(),
              );
            } else {
              return FaqsListView(
                faqs: _bloc.faqs,
                onRetry: () => requestFaqs(),
              );
            }
          },
        ),
      ),
    );
  }
}
