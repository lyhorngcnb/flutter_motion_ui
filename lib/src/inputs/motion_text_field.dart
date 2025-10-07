import 'package:flutter/material.dart';

class MotionTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final Color focusedBorderColor;
  final Color enabledBorderColor;
  final Color errorBorderColor;
  final Duration animationDuration;
  final Curve animationCurve;

  const MotionTextField({
    super.key,
    this.controller,
    required this.labelText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.validator,
    this.focusedBorderColor = Colors.blue,
    this.enabledBorderColor = Colors.grey,
    this.errorBorderColor = Colors.red,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  MotionTextFieldState createState() => MotionTextFieldState();
}

class MotionTextFieldState extends State<MotionTextField> {
  bool _isFocused = false;
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focused) {
        setState(() => _isFocused = focused);
      },
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged,
        validator: (value) {
          if (widget.validator != null) {
            final error = widget.validator!(value);
            setState(() => _hasError = error != null);
            return error;
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon)
              : null,
          suffixIcon: widget.suffixIcon != null
              ? Icon(widget.suffixIcon)
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: _hasError
                  ? widget.errorBorderColor
                  : widget.enabledBorderColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: _hasError
                  ? widget.errorBorderColor
                  : widget.focusedBorderColor,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: widget.errorBorderColor,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: widget.errorBorderColor,
              width: 2,
            ),
          ),
          labelStyle: TextStyle(
            color: _isFocused
                ? widget.focusedBorderColor
                : _hasError
                ? widget.errorBorderColor
                : Colors.grey,
          ),
        ),
      ),
    );
  }
}
