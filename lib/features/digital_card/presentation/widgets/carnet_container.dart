import 'package:flutter/material.dart';

class CarnetContainer extends StatelessWidget {
  final Widget child;
  // final Widget topLayer;

  const CarnetContainer({
    Key key,
    this.child,
    // this.topLayer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: child,
    );
  }

  // List<BoxShadow> _buildShadow() {
  //   return [
  //     BoxShadow(
  //       color: Colors.black.withOpacity(0.06),
  //       offset: const Offset(0.0, 6.0),
  //       blurRadius: 3.0,
  //       spreadRadius: 1.0,
  //     ),
  //     const BoxShadow(
  //       color: Colors.white,
  //       offset: Offset(0.0, 2.0),
  //     ),
  //   ];
  // }

  // LinearGradient _buildGradient() {
  //   return const LinearGradient(
  //     colors: [
  //       utils.AppColors.carnetDecorationColor,
  //       Colors.white,
  //       utils.AppColors.carnetDecorationColor,
  //     ],
  //     begin: FractionalOffset(-0.3, -0.3),
  //     end: FractionalOffset(1.0, 1.0),
  //   );
  // }
}
