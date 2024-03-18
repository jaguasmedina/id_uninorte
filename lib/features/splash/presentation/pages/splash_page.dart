import 'package:flutter/material.dart';

import 'package:identidaddigital/core/navigation/app_navigator.dart';
import 'package:identidaddigital/di/injection.dart';
import 'package:identidaddigital/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:identidaddigital/features/splash/presentation/widgets/widgets.dart';

class SplashPage extends StatefulWidget {
  /// Un-named route for [SplashPage].
  static Route route() {
    return MaterialPageRoute<dynamic>(builder: (_) => SplashPage());
  }

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _bloc = sl<SplashBloc>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startApp();
    });
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  Future<void> _startApp() async {
    final routeName = await _bloc.initConfiguration();
    AppNavigator.navigator.pushReplacementNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: LaunchImage(),
        ),
      ),
    );
  }
}
