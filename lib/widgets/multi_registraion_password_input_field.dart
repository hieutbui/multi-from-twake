import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:password_strength_indicator/password_strength_indicator.dart';

class MultiRegistrationPasswordInputField extends StatefulWidget {
  final Key fieldKey;
  final FocusNode focusNode;
  final TextEditingController controller;
  final bool? isRequired;
  final bool isObscured;
  final bool? isShowPasswordStrength;

  const MultiRegistrationPasswordInputField({
    super.key,
    required this.fieldKey,
    required this.focusNode,
    required this.controller,
    this.isRequired,
    this.isObscured = true,
    this.isShowPasswordStrength = true,
  });

  @override
  State<MultiRegistrationPasswordInputField> createState() =>
      _MultiRegistrationPasswordInputFieldState();
}

class _MultiRegistrationPasswordInputFieldState
    extends State<MultiRegistrationPasswordInputField> {
  late bool _isObscured;
  late ValueNotifier<double> _strength;
  late String _password;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChange);
    _isObscured = widget.isObscured;
    _strength = ValueNotifier(0.0);
    _password = widget.controller.text;
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChange);
    _strength.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
            controller: widget.controller,
            onChanged: _onPasswordChanged,
            name: 'Password',
            focusNode: widget.focusNode,
            obscureText: _isObscured,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.password(
                minLength: 8,
                errorText: 'Password must be at least 8 characters long',
                checkNullOrEmpty: true,
              ),
              if (widget.isRequired ?? false)
                FormBuilderValidators.required(
                  errorText: 'Password is required',
                ),
            ]),
            style: TextStyle(
              fontSize: 17.0,
              color:
                  Colors.white.withAlpha(222) /* Text-Main-Primary_Default */,
              fontFamily: 'SFPro',
              fontWeight: FontWeight.w400,
              letterSpacing: -0.41,
              height: 1.18,
            ),
            decoration: InputDecoration(
              label: Text(
                'Password',
                style: TextStyle(
                  fontSize: 17.0,
                  color: Colors.white
                      .withAlpha(97) /* Text-Main-Tertiary-disabled */,
                  fontFamily: 'SFPro',
                  fontWeight: FontWeight.w400,
                  height: 1.27,
                  letterSpacing: 0.06,
                ),
              ),
              hintText: 'Password',
              hintStyle: TextStyle(
                fontSize: 17.0,
                color: Colors.white
                    .withAlpha(97) /* Text-Main-Tertiary-disabled */,
                fontFamily: 'SFPro',
                fontWeight: FontWeight.w400,
                letterSpacing: -0.41,
                height: 1.18,
              ),
              border: InputBorder.none,
              suffixIcon: IconButton(
                onPressed: _toggleObscured,
                icon: Icon(
                  _isObscured
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.white.withAlpha(97),
                  size: 24.0,
                ),
              ),
            ),
            keyboardType: TextInputType.visiblePassword,
          ),
        ),
        const SizedBox(height: 12.0),
        if (widget.isShowPasswordStrength == true)
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: PasswordStrengthIndicator(
                    password: _password,
                    colors: const StrengthColors(
                      weak: Color(0xFFEE9D41) /* State-Attention-Text-Main */,
                      medium: Colors.yellow,
                      strong:
                          Color(0xFF70BC7E) /* State-Success-Text-Default */,
                    ),
                    duration: const Duration(milliseconds: 300),
                    thickness: 4.0,
                    callback: _updateStrength,
                    curve: Curves.easeOut,
                    style: StrengthBarStyle.dashed,
                  ),
                ),
                const SizedBox(width: 12.0),
                ValueListenableBuilder(
                  valueListenable: _strength,
                  builder: (context, strength, child) {
                    return Text(
                      _generatePasswordStrengthText(strength),
                      style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'SFPro',
                        fontWeight: FontWeight.w500,
                        height: 1.38,
                        letterSpacing: -0.08,
                        color: _getStrengthColor(strength),
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }

  void _onFocusChange() {
    setState(() {});
  }

  void _toggleObscured() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  void _updateStrength(double strength) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _strength.value = strength;
    });
  }

  String _generatePasswordStrengthText(double strength) {
    if (strength == 0) {
      return 'Strength';
    } else if (strength < 1 / 3) {
      return 'Not strong enough';
    } else if (strength < 2 / 3) {
      return 'Good';
    } else {
      return 'Account protected';
    }
  }

  Color _getStrengthColor(double strength) {
    if (strength == 0) {
      return Colors.white;
    } else if (strength < 1 / 3) {
      return const Color(0xFFEE9D41) /* State-Attention-Text-Main */;
    } else if (strength < 2 / 3) {
      return Colors.yellow;
    } else {
      return const Color(0xFF70BC7E) /* State-Success-Text-Default */;
    }
  }

  void _onPasswordChanged(String? value) {
    setState(() {
      _password = value ?? '';
    });
  }
}
