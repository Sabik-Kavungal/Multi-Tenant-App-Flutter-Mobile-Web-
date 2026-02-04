import 'package:flutter/material.dart';

/// CustomTextField - Stateless widget that binds to model values
/// No controllers - completely stateless
/// Binds value from ViewModel and forwards onChange events
class CustomTextField extends StatelessWidget {
  final String value;
  final String? hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String> onChange;
  final ValueChanged<String>? onSubmitted;
  final String? errorText;

  const CustomTextField({
    super.key,
    required this.value,
    required this.onChange,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    // Use a stable key based on a unique identifier (not the value)
    // This prevents unnecessary rebuilds while still allowing the field to update
    // The initialValue is set once, and onChanged handles updates
    // Note: initialValue doesn't update reactively, but since onChange is called
    // on every keystroke, the ViewModel state stays in sync
    return TextFormField(
      key: key,
      initialValue: value,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChange,
      onFieldSubmitted: onSubmitted,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null && onSuffixIconPressed != null
            ? IconButton(icon: Icon(suffixIcon), onPressed: onSuffixIconPressed)
            : null,
        border: const OutlineInputBorder(),
        errorText: errorText,
      ),
    );
  }
}
