import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class MultiRegistrationEmailInputField extends StatefulWidget {
  final Key fieldKey;
  final FocusNode focusNode;
  final TextEditingController controller;
  final bool? isRequired;

  const MultiRegistrationEmailInputField({
    super.key,
    required this.fieldKey,
    required this.focusNode,
    required this.controller,
    this.isRequired,
  });

  @override
  State<MultiRegistrationEmailInputField> createState() =>
      _MultiRegistrationEmailInputFieldState();
}

class _MultiRegistrationEmailInputFieldState
    extends State<MultiRegistrationEmailInputField> {
  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1D1F26) /* Background-Inputs-Default */,
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        border: Border.all(
          color: widget.focusNode.hasFocus
              ? const Color(0xFF5F87B4) /* Borders-Main-Active */
              : Colors.transparent,
          width: 1.0,
        ),
      ),
      child: FormBuilderTextField(
        key: widget.fieldKey,
        name: 'Email address',
        controller: widget.controller,
        focusNode: widget.focusNode,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.email(
            errorText: 'Please enter a valid email address',
          ),
          if (widget.isRequired ?? false)
            FormBuilderValidators.required(
              errorText: 'Email address is required',
            ),
        ]),
        style: TextStyle(
          fontSize: 17.0,
          color: Colors.white.withAlpha(222) /* Text-Main-Primary_Default */,
          fontFamily: 'SFPro',
          fontWeight: FontWeight.w400,
          letterSpacing: -0.41,
          height: 1.18,
        ),
        decoration: InputDecoration(
          label: Text(
            'Email address',
            style: TextStyle(
              fontSize: 17.0,
              color:
                  Colors.white.withAlpha(97) /* Text-Main-Tertiary-disabled */,
              fontFamily: 'SFPro',
              fontWeight: FontWeight.w400,
              height: 1.27,
              letterSpacing: 0.06,
            ),
          ),
          hintText: 'Email address',
          hintStyle: TextStyle(
            fontSize: 17.0,
            color: Colors.white.withAlpha(97) /* Text-Main-Tertiary-disabled */,
            fontFamily: 'SFPro',
            fontWeight: FontWeight.w400,
            letterSpacing: -0.41,
            height: 1.18,
          ),
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  void _onFocusChange() {
    setState(() {});
  }
}
