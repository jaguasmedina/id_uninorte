import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

import 'package:identidaddigital/core/presentation/widgets/widgets.dart';
import 'package:identidaddigital/features/digital_card/constants/tags.dart';

class BarCodeFullPage extends StatelessWidget {
  final String barcode;

  const BarCodeFullPage({
    Key key,
    @required this.barcode,
  }) : super(key: key);

  /// Un-named route for [BarCodeFullPage].
  static Route<void> route(String barcode) {
    return MaterialPageRoute(
      builder: (_) => BarCodeFullPage(barcode: barcode),
    );
  }

  @override
  Widget build(BuildContext context) {
    void pop() => Navigator.of(context).pop();

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: UserAppBar(
        onLeadingPressed: pop,
      ),
      body: Center(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: pop,
          child: Container(
            width: double.infinity,
            height: size.width / 2,
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            child: _BarCodeHero(
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..rotateZ(math.pi / 2),
                child: BarcodeWidget(
                  barcode: Barcode.code128(),
                  data: barcode,
                  drawText: false,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BarCodeHero extends StatelessWidget {
  final Widget child;

  const _BarCodeHero({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: kBarcodeHeroTag,
      flightShuttleBuilder: (
        BuildContext flightContext,
        Animation<double> animation,
        HeroFlightDirection flightDirection,
        BuildContext fromHeroContext,
        BuildContext toHeroContext,
      ) {
        final Hero fromHero = fromHeroContext.widget;

        final rotation = Tween(
          begin: 0.0,
          end: math.pi / 2,
        ).animate(animation);

        return AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            final transform = Matrix4.identity()..rotateZ(rotation.value);
            return Transform(
              alignment: Alignment.center,
              transform: transform,
              child: fromHero.child,
            );
          },
        );
      },
      child: child,
    );
  }
}
