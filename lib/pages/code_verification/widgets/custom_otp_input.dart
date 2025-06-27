import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomOtpInput extends StatelessWidget {
  const CustomOtpInput({
    super.key,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.isError,
    this.autoFocus,
  });

  /// Controller to manage the text input
  final TextEditingController? controller;

  /// Focus node to manage focus state
  final FocusNode? focusNode;

  /// Callback triggered when input value changes
  final Function(String)? onChanged;

  /// Callback triggered when user submits input
  final Function(String)? onSubmitted;

  /// Flag to show error state styling
  final bool? isError;

  /// Flag to automatically focus this input
  final bool? autoFocus;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF1D1F26),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (isError ?? false) ? Colors.red : Colors.transparent,
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        autofocus: autoFocus ?? false,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontFamily: 'SFPro',
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        decoration: InputDecoration(
          counterText: '',
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFF3B82F6),
              width: 2,
            ),
          ),
          enabledBorder: InputBorder.none,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
        ),
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      ),
    );
  }
}
