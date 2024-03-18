import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:identidaddigital/core/extensions/size_extension.dart';
import 'package:identidaddigital/core/presentation/widgets/widgets.dart';

class GradientTextFormField extends FormField<String> {
  GradientTextFormField({
    Key key,
    String initialValue,
    String hintText,
    bool obscureText = false,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    FocusNode focusNode,
    TextInputType keyboardType,
    TextInputAction textInputAction,
    ValueChanged<String> onChanged,
    ValueChanged<String> onSaved,
    ValueChanged<String> onFieldSubmitted,
    FormFieldValidator<String> validator,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidateMode: autovalidateMode,
          builder: (FormFieldState<String> field) {
            void onChangedHandler(String value) {
              if (onChanged != null) {
                onChanged(value);
              }
              field.didChange(value);
            }

            return GradientTextField(
              initialValue: field.value,
              hintText: hintText,
              obscureText: obscureText,
              focusNode: focusNode,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              hasError: field.hasError,
              errorText: field.errorText,
              onFieldSubmitted: onFieldSubmitted,
              onChanged: onChangedHandler,
            );
          },
        );
}

class GradientTextField extends StatelessWidget {
  final bool obscureText;
  final bool hasError;
  final String errorText;
  final String initialValue;
  final String hintText;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSaved;
  final ValueChanged<String> onFieldSubmitted;
  final FormFieldValidator<String> validator;

  const GradientTextField({
    Key key,
    this.initialValue,
    this.hintText = '',
    this.errorText,
    this.hasError = false,
    this.obscureText = false,
    this.focusNode,
    this.keyboardType,
    this.textInputAction = TextInputAction.done,
    this.onSaved,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      _buildDecoratedtextField(context),
    ];

    if (hasError && errorText != null) {
      children.add(_buildErrorText(context));
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }

  Widget _buildDecoratedtextField(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        gradient: const LinearGradient(
          begin: FractionalOffset(0.0, 0.2),
          end: FractionalOffset(0.0, 1.6),
          colors: [Colors.white, Colors.grey],
        ),
      ),
      child: TextFormField(
        initialValue: initialValue,
        focusNode: focusNode,
        obscureText: obscureText,
        style: const TextStyle(fontSize: 15.0),
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        onSaved: onSaved,
        validator: validator,
        inputFormatters: <TextInputFormatter>[
          WhiteSpaceTextInputFormatter(),
        ],
        decoration: InputDecoration(
          isDense: size.isMobile,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 10.0,
          ),
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    );
  }

  Widget _buildErrorText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0, left: 2.0),
      child: Text(
        errorText,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 12.0,
          color: Theme.of(context).errorColor,
        ),
      ),
    );
  }
}
