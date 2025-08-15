import 'package:flutter/material.dart';
import 'package:identidaddigital/core/theme/app_theme.dart';
import 'package:identidaddigital/core/utils/utils.dart' show MyIcons;

/// Barra inferior de la tarjeta digital que contiene los botones de acción.
///
/// **Cambios realizados para solucionar problemas de iconos:**
/// - **Problema identificado**: Los iconos personalizados no se veían debido a problemas de contraste de color
/// - **Causa raíz**: Iconos blancos sobre fondo blanco (primaryColor = blanco)
/// - **Solución aplicada**: Especificación explícita de colores para todos los iconos
///   - Botones laterales: Iconos negros sobre fondo blanco
///   - Botón central: Icono negro sobre fondo blanco
///
/// **Iconos utilizados:**
/// - `MyIcons.settings`: Configuración (botón izquierdo)
/// - `MyIcons.refresh`: Voltear tarjeta (botón derecho)
/// - `MyIcons.capture`: Cámara/foto (botón central)

class BottomBar extends StatelessWidget {
  static const _height = 64.0;

  final ValueChanged<int> onPressed;

  const BottomBar({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    final media = MediaQuery.of(context);
    final size = media.size;
    final height = _height + (media.padding.bottom * 0.7);

    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(
          height: height,
          width: double.infinity,
          margin: const EdgeInsets.only(left: 32.0, right: 32.0, top: 36.0),
          decoration: BoxDecoration(
            color: appTheme.secondaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _TileIconButton(
                  key: const Key('settings_button'),
                  icon: MyIcons.settings,
                  onPressed: () => onPressed(0),
                ),
                _TileIconButton(
                  key: const Key('flip_button'),
                  icon: MyIcons.refresh,
                  onPressed: () => onPressed(1),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -24.0 + 36.0,
          left: (size.width / 2) - 40,
          child: _CircularIconButton(
            onTap: () => onPressed(2),
          ),
        )
      ],
    );
  }
}

class _CircularIconButton extends StatelessWidget {
  final VoidCallback? onTap;

  const _CircularIconButton({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        width: 80.0,
        height: 80.0,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: appTheme.primaryColor,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              blurRadius: 12.0,
              color: Colors.black12,
            ),
          ],
        ),
        child: const FittedBox(
          child: Icon(
            MyIcons.capture,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class _TileIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _TileIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: AppTheme.of(context).primaryColor,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(12.0),
        minimumSize: const Size(46, 46),
      ),
      child: Icon(icon, size: 30, color: Colors.black),
    );
  }
}
