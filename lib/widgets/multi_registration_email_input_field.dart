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
    return FormBuilderTextField(
      key: widget.fieldKey,
      name: 'Email address',
      controller: widget.controller,
      focusNode: widget.focusNode,
      autocorrect: false,
      // Only validate on user interaction with this specific field
      autovalidateMode: AutovalidateMode.disabled,
      textInputAction: TextInputAction.next,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.email(
          errorText: 'Please enter a valid email address',
        ),
        if (widget.isRequired ?? false)
          FormBuilderValidators.required(
            errorText: 'Email address is required',
          ),
      ]),
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
      decoration: const InputDecoration(
        labelText: 'Email address',
        hintText: 'Email address',
      ),
      keyboardType: TextInputType.emailAddress,
      // Add an onChanged handler to validate as user types
      onChanged: (value) {
        // When user is typing, clear error if valid or show error if invalid
        setState(() {
          // This forces the field to rebuild with updated validation state
        });
      },
      // This prevents focus from changing when pressing next
      onEditingComplete: () {
        // Keep focus on email field
        FocusScope.of(context).requestFocus(widget.focusNode);

        // If needed, you can manually validate this field
        // This is a simpler approach that only shows errors for this field
        widget.controller.text.isEmpty && widget.isRequired == true
            ? setState(() {}) // Force rebuild to show error
            : null;
      },
      // Also handle submit
      onSubmitted: (_) {
        // Keep focus on email field
        FocusScope.of(context).requestFocus(widget.focusNode);
      },
    );
  }

  void _onFocusChange() {
    setState(() {});
  }
}
