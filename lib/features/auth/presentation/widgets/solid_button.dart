import 'package:flutter/material.dart';
import 'package:identidaddigital/core/extensions/size_extension.dart';
import 'package:identidaddigital/core/utils/utils.dart' as utils;

class SolidButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SolidButton({
    Key key,
    @required this.title,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: const LinearGradient(
          begin: FractionalOffset(0.0, 0.2),
          end: FractionalOffset(0.0, 1.0),
          colors: [
            utils.AppColors.institutionalColor,
            utils.AppColors.accentDarkColor,
          ],
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: size.isMobile ? 10.0 : 16.0,
            ),
            child: Text(
              title.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
