import 'package:fluffychat/config/multi_sys_variables/multi_colors.dart';
import 'package:fluffychat/widgets/custom_password_strength_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:password_strength_indicator/password_strength_indicator.dart';

class _Constants {
  static const Color indicatorWeekColor = Color(0xFFEE9D41);
  static const Color indicatorMediumColor = Colors.yellow;
  static const Color indicatorStrongColor = Color(0xFF70BC7E);
}

class MultiRegistrationPasswordInputField extends StatefulWidget {
  final Key fieldKey;
  final FocusNode focusNode;
  final TextEditingController controller;
  final bool? isRequired;
  final bool isObscured;
  final bool? isShowPasswordStrength;
  final bool isValidatePasswordStrength;
  final bool isShowErrorValidator;

  const MultiRegistrationPasswordInputField({
    super.key,
    required this.fieldKey,
    required this.focusNode,
    required this.controller,
    this.isRequired,
    this.isObscured = true,
    this.isShowPasswordStrength = true,
    this.isValidatePasswordStrength = true,
    this.isShowErrorValidator = true,
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
        FormBuilderTextField(
          key: widget.fieldKey,
          controller: widget.controller,
          autocorrect: false,
          onChanged: (value) {
            // Update strength indicator
            _onPasswordChanged(value);

            // Force the form to rebuild to update validation errors
            setState(() {});
          },
          name: 'Password',
          focusNode: widget.focusNode,
          obscureText: _isObscured,
          // Keep autovalidateMode to clear errors as you type
          autovalidateMode: AutovalidateMode.onUserInteraction,
          // Use simpler minLength validator that just checks length
          validator: widget.isShowErrorValidator ? _validator : null,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'Password',
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
                  child: ValueListenableBuilder(
                    valueListenable: _strength,
                    builder: (context, strength, child) {
                      return CustomPasswordStrengthIndicator(
                        password: _password,
                        colors: getStrengthColorsOfIndicator(strength, context),
                        backgroundColor: Theme.of(context).brightness ==
                                Brightness.dark
                            ? const MultiDarkColors().additionalNeutralGrey
                            : const MultiLightColors().backgroundInputsDefault,
                        duration: const Duration(milliseconds: 300),
                        thickness: 4.0,
                        callback: _updateStrength,
                        curve: Curves.easeOut,
                        style: StrengthBarStyle.dashed,
                        strengthBuilder: (String password) {
                          return _calculatePasswordStrength(password);
                        },
                      );
                    },
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
                        color: _getStrengthColor(strength, context),
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

  Color _getStrengthColor(double strength, BuildContext context) {
    if (strength == 0) {
      return Theme.of(context).brightness == Brightness.dark
          ? const MultiDarkColors().additionalNeutralGrey
          : const MultiLightColors().backgroundInputsDefault;
    } else if (strength < 1 / 3) {
      return _Constants.indicatorWeekColor;
    } else if (strength < 2 / 3) {
      return _Constants.indicatorMediumColor;
    } else {
      return _Constants.indicatorStrongColor;
    }
  }

  void _onPasswordChanged(String? value) {
    setState(() {
      _password = value ?? '';
    });
  }

  // TODO: Write document + test for this function
  double _calculatePasswordStrength(String password) {
    if (password.isEmpty) return 0.0;

    // Count basic criteria (must have 5/5 to be strong)
    int basicScore = 0;

    // 1. Check minimum length (8 characters) - BASIC
    if (password.length >= 8) {
      basicScore += 1;
    }

    // 2. Check for at least 1 uppercase letter - BASIC
    if (RegExp(r'[A-Z]').hasMatch(password)) {
      basicScore += 1;
    }

    // 3. Check for at least 1 lowercase letter - BASIC
    if (RegExp(r'[a-z]').hasMatch(password)) {
      basicScore += 1;
    }

    // 4. Check for at least 1 number - BASIC
    if (RegExp(r'[0-9]').hasMatch(password)) {
      basicScore += 1;
    }

    // 5. Check for at least 1 special character - BASIC
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      basicScore += 1;
    }

    // Bonus criteria (does not affect basic strength requirement)
    int bonusScore = 0;

    // 6. Check for longer password (14+ characters for extra security) - BONUS
    if (password.length >= 14) {
      bonusScore += 1;
    }

    // Apply strict logic: need all 5 basic criteria to be strong
    double strength;

    if (basicScore < 2) {
      // Very weak: 0 - 0.33 range
      strength = (basicScore / 5.0) * 0.33;
    } else if (basicScore < 5) {
      // Medium: 0.33 - 0.67 range (cannot exceed medium without all 5 basic criteria)
      strength =
          0.33 + ((basicScore - 2) / 3.0) * 0.34; // Maps score 2-4 to 0.33-0.67
    } else {
      // Strong: 0.67 - 1.0 range (only when all 5 basic criteria met)
      // Bonus score can push it higher within strong range
      strength = 0.67 + (bonusScore / 1.0) * 0.33; // Maps bonus 0-1 to 0.67-1.0
    }

    // Apply additional penalty for very short passwords improve UX
    if (password.length < 4) {
      strength *= 0.3;
    } else if (password.length < 6) {
      strength *= 0.6;
    }

    // Ensure the result is between 0.0 and 1.0
    return strength.clamp(0.0, 1.0);
  }

  String? _validator(String? value) {
    if (!widget.focusNode.hasFocus) return null;

    return FormBuilderValidators.compose([
      FormBuilderValidators.password(
        maxLength: 99,
        errorText: 'Your password is not strong enough',
      ),
      if (widget.isRequired ?? false)
        FormBuilderValidators.required(
          errorText: 'Password is required',
        ),
    ])(value);
  }

  StrengthColors getStrengthColorsOfIndicator(
    double strength,
    BuildContext context,
  ) {
    if (strength == 0) {
      return const StrengthColors(
        weak: _Constants.indicatorWeekColor,
        medium: _Constants.indicatorMediumColor,
        strong: _Constants.indicatorStrongColor,
      );
    } else if (strength < 1 / 3) {
      return const StrengthColors(
        weak: _Constants.indicatorWeekColor,
        medium: _Constants.indicatorWeekColor,
        strong: _Constants.indicatorWeekColor,
      );
    } else if (strength < 2 / 3) {
      return const StrengthColors(
        weak: _Constants.indicatorMediumColor,
        medium: _Constants.indicatorMediumColor,
        strong: _Constants.indicatorMediumColor,
      );
    } else {
      return const StrengthColors(
        weak: _Constants.indicatorStrongColor,
        medium: _Constants.indicatorStrongColor,
        strong: _Constants.indicatorStrongColor,
      );
    }
  }
}
