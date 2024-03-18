import 'package:flutter/material.dart';
import 'package:identidaddigital/core/presentation/widgets/widgets.dart';

class DialogManager {
  /// Shows a non dismissible loading pop-up.
  static Future<void> showLoading({
    @required BuildContext context,
    String title,
  }) {
    return _showGeneralDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: LoadingDialog(title: title),
        );
      },
    );
  }

  /// Shows a dismissible pop-up with a single action.
  static Future<void> showMessage({
    @required BuildContext context,
    String title,
    String message,
    String buttonText,
  }) {
    return _showGeneralDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertMessage(
          title: title,
          message: message,
          buttonText: buttonText,
          onPressed: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  /// Shows a dismissible pop-up with actions.
  static Future<bool> showAskDialog({
    @required BuildContext context,
    @required String message,
    IconData icon,
    String confirmText,
    String cancelText,
  }) async {
    return await _showGeneralDialog<bool>(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext buildContext) {
            return ActionDialog(
              icon: icon,
              message: message,
              confirmText: confirmText,
              cancelText: cancelText,
              onCanceled: () => Navigator.of(context).pop(false),
              onConfirmed: () => Navigator.of(context).pop(true),
            );
          },
        ) ??
        false;
  }

  static Future<T> showMyGeneralDialog<T>({
    @required BuildContext context,
    @required WidgetBuilder builder,
    bool barrierDismissible = true,
  }) =>
      _showGeneralDialog(
        context: context,
        builder: builder,
        barrierDismissible: barrierDismissible,
      );

  /// Shows a custom animated dialog.
  static Future<T> _showGeneralDialog<T>({
    @required BuildContext context,
    @required WidgetBuilder builder,
    bool barrierDismissible = true,
  }) {
    return showGeneralDialog<T>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black54,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return FadeScaleTransition(animation: animation, child: child);
      },
      pageBuilder: (
        BuildContext buildContext,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return Builder(builder: builder);
      },
    );
  }
}
