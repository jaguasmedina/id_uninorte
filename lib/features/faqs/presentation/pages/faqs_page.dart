import 'package:flutter/material.dart';

import 'package:identidaddigital/core/enums/page_state.dart';
import 'package:identidaddigital/core/i18n/app_localizations.dart';
import 'package:identidaddigital/core/presentation/providers/providers.dart';
import 'package:identidaddigital/core/presentation/widgets/widgets.dart';
import 'package:identidaddigital/core/theme/app_theme.dart';
import 'package:identidaddigital/di/injection.dart';
import 'package:identidaddigital/features/faqs/presentation/bloc/faqs_bloc.dart';
import 'package:identidaddigital/features/faqs/presentation/widgets/faqs_empty_view.dart';
import 'package:identidaddigital/features/faqs/presentation/widgets/faqs_list_view.dart';
import 'package:provider/provider.dart';

class FaqsPage extends StatefulWidget {
  /// Anonymous route for [FaqsPage].
  static Route<void> route() {
    return MaterialPageRoute(builder: (_) => FaqsPage());
  }

  @override
  _FaqsPageState createState() => _FaqsPageState();
}

class _FaqsPageState extends State<FaqsPage> {
  final _bloc = sl<FaqsBloc>();

  @override
  void initState() {
    super.initState();
    requestFaqs();
  }

  void requestFaqs() {
    final user = Provider.of<UserProvider>(
      context,
      listen: false,
    ).user;
    final isUnauthenticated = user == null;

    if (isUnauthenticated) {
      _bloc.requestExternalFaqs();
    } else {
      _bloc.requestFaqs();
    }
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: user != null
          ? UserAppBar(
              backgroundColor: AppTheme.of(context).secondaryHeaderColor,
              onLeadingPressed: () => Navigator.of(context).pop(),
              trailing: LabeledView(
                label: getString(context, 'settings_help'),
                position: LabelPosition.left,
                child: const Icon(Icons.help_outline, size: 30.0),
              ),
            )
          : SimpleAppBar(
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
