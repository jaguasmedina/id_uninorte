import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:identidaddigital/core/enums/enums.dart';
import 'package:identidaddigital/core/presentation/bloc/bloc.dart';

typedef BlocWidgetBuilder = Widget Function(
  BuildContext context,
  PageState state,
);

class BlocBuilder<T extends BaseBloc> extends StatelessWidget {
  final T bloc;
  final BlocWidgetBuilder builder;

  const BlocBuilder({
    Key key,
    @required this.bloc,
    @required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<T>(
      create: (_) => bloc,
      child: StreamBuilder<PageState>(
        stream: bloc.stream,
        initialData: bloc.initialState,
        builder: (context, snapshot) {
          return builder(context, snapshot.data);
        },
      ),
    );
  }
}
