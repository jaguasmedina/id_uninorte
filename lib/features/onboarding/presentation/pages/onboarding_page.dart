import 'package:flutter/material.dart';

import 'package:identidaddigital/core/presentation/widgets/widgets.dart';
import 'package:identidaddigital/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:identidaddigital/features/onboarding/presentation/widgets/widgets.dart';
import 'package:identidaddigital/features/onboarding/presentation/widgets/slides/slides.dart';
import 'package:identidaddigital/di/injection.dart';

class OnboardingPage extends StatefulWidget {
  /// Un-named route for [OnboardingPage].
  static Route route() {
    return FadeRoute<dynamic>(OnboardingPage());
  }

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _bloc = sl<OnboardingBloc>();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  void _finishOnboarding() {
    final destination = _bloc.requestDestination();
    _bloc.saveOnboardingDidShow();
    Navigator.of(context).pushReplacementNamed(destination);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlideShow(
        slides: <Widget>[
          const WelcomeSlide(),
          const CarnetInfoSlide(),
          const CodesSlide(),
          ConfigurationSlide(
            onStart: _finishOnboarding,
          ),
        ],
      ),
    );
  }
}
