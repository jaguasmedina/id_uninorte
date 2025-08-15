import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OutlineTextFormField extends StatelessWidget {
  final bool obscureText;
  final String hintText;
  final String? errorText;
  final int? maxLines;
  final int? hintMaxLines;
  final bool expands;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextAlignVertical? textAlignVertical;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;

  const OutlineTextFormField({
    Key? key,
    required this.hintText,
    this.errorText,
    this.maxLength,
    this.obscureText = false,
    this.maxLines,
    this.expands = false,
    this.hintMaxLines,
    this.keyboardType,
    this.textAlignVertical,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.controller,
    this.validator,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      obscureText: obscureText,
      validator: validator,
      onSaved: onSaved,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      maxLines: maxLines,
      expands: expands,
      controller: controller,
      textAlignVertical: textAlignVertical,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        errorMaxLines: 5,
        errorText: errorText,
        hintMaxLines: hintMaxLines,
        border: _buildBorder(context),
        enabledBorder: _buildBorder(context),
        focusedBorder: _buildBorder(context),
        errorBorder: _buildErrorBorder(context),
        focusedErrorBorder: _buildErrorBorder(context),
      ),
    );
  }

  InputBorder _buildBorder(BuildContext context) {
    return OutlineInputBorder(
      borderSide: const BorderSide(width: 2.0),
      borderRadius: BorderRadius.circular(8.0),
    );
  }

  InputBorder _buildErrorBorder(BuildContext context) {
    return OutlineInputBorder(
      borderSide: const BorderSide(width: 2.0, color: Colors.red),
      borderRadius: BorderRadius.circular(8.0),
    );
  }
}
