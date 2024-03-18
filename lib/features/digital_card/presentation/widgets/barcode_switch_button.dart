import 'package:flutter/material.dart';
import 'package:identidaddigital/core/utils/assets.dart';

class BarcodeSwitchButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const BarcodeSwitchButton({
    Key key,
    @required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            const SizedBox(
              height: 40.0,
              child: Image(
                image: AssetImage(Assets.barcode),
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
