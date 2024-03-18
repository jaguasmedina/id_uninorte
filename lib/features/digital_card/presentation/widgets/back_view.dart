import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:identidaddigital/core/error/failures.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:identidaddigital/core/i18n/app_localizations.dart';
import 'package:identidaddigital/core/presentation/widgets/widgets.dart';
import 'package:identidaddigital/features/digital_card/constants/tags.dart';
import 'package:identidaddigital/features/digital_card/domain/entities/barcode_item.dart';
import 'package:identidaddigital/features/digital_card/presentation/widgets/animation_notifier.dart';
import 'package:identidaddigital/features/digital_card/presentation/widgets/barcode_switch_button.dart';
import 'package:identidaddigital/features/digital_card/presentation/widgets/logo_image.dart';

class BackView extends StatefulWidget {
  final String barcode;
  final String label;
  final AsyncSnapshot<String> qrSnapshot;
  final VoidCallback onQrPressed;
  final VoidCallback onBarcodePressed;
  final VoidCallback onQrError;
  final ValueChanged<BarcodeItem> onBarcodeViewChanged;

  const BackView({
    Key key,
    @required this.qrSnapshot,
    @required this.barcode,
    @required this.label,
    @required this.onQrPressed,
    @required this.onBarcodePressed,
    @required this.onQrError,
    @required this.onBarcodeViewChanged,
  }) : super(key: key);

  @override
  _BackViewState createState() => _BackViewState();
}

class _BackViewState extends State<BackView> {
  BarcodeItem _barcodeItem;

  @override
  void initState() {
    super.initState();
    _barcodeItem = QRCodeItem();
  }

  void _toggleBarcodeItem() {
    final barcodeItem = _barcodeItem.isQR ? LinearBarcodeItem() : QRCodeItem();
    widget.onBarcodeViewChanged(barcodeItem);
    setState(() {
      _barcodeItem = barcodeItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAnimating = AnimationNotifier.of(context).isAnimating;
    final localizations = AppLocalizations.of(context);
    return DayNightAnnotatedRegion(
      brightness: Brightness.light,
      child: Transform(
        transform: Matrix4.rotationY(math.pi),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 10.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(top: 40.0),
                      child: LogoImage(),
                    ),
                    Flexible(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: _barcodeItem.isQR
                            ? _buildQr(isAnimating)
                            : _buildBarcode(context, isAnimating),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(localizations.translate('qr_code_message'),textAlign: TextAlign.justify,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: BarcodeSwitchButton(
                        title: getString(context, _barcodeItem.label),
                        onTap: _toggleBarcodeItem,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildBottomLabel(context),
          ],
        ),
      ),
    );
  }

  Widget _buildQr(bool isAnimating) {
    Widget child;

    if (isAnimating) {
      child = Container(key: const ValueKey(1));
    } else if (widget.qrSnapshot.hasData) {
      child = GestureDetector(
        onTap: widget.onQrPressed,
        child: Hero(
          tag: kQrCodeHeroTag,
          child: QrImage(
            key: const ValueKey(2),
            data: widget.qrSnapshot.data,
          ),
        ),
      );
    } else if (widget.qrSnapshot.hasError) {
      final dynamic error = widget.qrSnapshot.error;
      var message = getString(context, 'access_code_error_message');

      if (error is ServerFailure && error.message != null) {
        message = error.message;
      } else if (error is Failure) {
        message = getString(context, error.key);
      }

      return ConstrainedBox(
        constraints: BoxConstraints.loose(const Size.fromWidth(400)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4.copyWith(
                    fontSize: 23,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8.0),
            PrimaryButton(
              title: getString(context, 'retry'),
              onPressed: widget.onQrError,
            ),
          ],
        ),
      );
    } else {
      child = const CircularProgressIndicator();
    }
    return FractionallySizedBox(
      widthFactor: 0.78,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: child,
        ),
      ),
    );
  }

  Widget _buildBarcode(BuildContext context, bool isAnimating) {
    return ResponsiveBuilder(
      builder: (BuildContext context, ScreenType screenType) {
        final barHeight = screenType.isMobile ? 120.0 : 170.0;
        final verticalPadding = screenType.isMobile ? 8.0 : 24.0;
        Widget child;
        if (isAnimating) {
          child = SizedBox(
            height: barHeight,
            child: Container(),
          );
        } else {
          child = GestureDetector(
            onTap: widget.onBarcodePressed,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: verticalPadding),
              child: SizedBox(
                width: double.infinity,
                height: barHeight,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: _BarCodeHero(
                    child: BarcodeWidget(
                      barcode: Barcode.code128(),
                      data: widget.barcode,
                      drawText: false,
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return FractionallySizedBox(
          widthFactor: 0.9,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: child,
          ),
        );
      },
    );
  }

  Widget _buildBottomLabel(BuildContext context) {
    return ResponsiveBuilder(
      builder: (BuildContext context, ScreenType screenType) {
        final isMobile = screenType.isMobile;
        return Container(
          height: isMobile ? 60.0 : 80.0,
          width: double.infinity,
          color: Theme.of(context).accentColor,
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 8.0 : 12.0,
            horizontal: isMobile ? 40.0 : 60.0,
          ),
          child: FittedBox(
            child: Text(
              widget.label.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        );
      },
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
        final Hero toHero = toHeroContext.widget;

        final rotation = Tween(
          begin: 0.0,
          end: math.pi / 2,
        ).animate(animation);

        return AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..rotateZ(rotation.value),
              child: toHero.child,
            );
          },
        );
      },
      child: child,
    );
  }
}
