import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class SFForgotPasswordForm extends StatefulWidget {
  final ComponentSize size;
  final double spacing;
  final Function(Map<String, dynamic>)? onSubmit;

  const SFForgotPasswordForm({
    super.key,
    this.onSubmit,
    this.size = ComponentSize.md,
    this.spacing = AppSpacing.sm,
  });

  @override
  State<SFForgotPasswordForm> createState() => _SFForgotPasswordFormState();
}

class _SFForgotPasswordFormState extends State<SFForgotPasswordForm> {
  final form = FormGroup({
    'email': FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
  });

  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: form.control('email').value);

    _emailController.addListener(() {
      form.control('email').value = _emailController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: widget.spacing,
      children: [
        SFFormfield(
          isRequired: form
              .control('email')
              .validators
              .any((validator) => validator == Validators.required),
          label: 'Email',
          input: SFTextField(
            placeholder: 'Enter your email',
            controller: _emailController,
            size: widget.size,
            isInError:
                form.control('email').touched && form.control('email').invalid,
          ),
          errorMessage:
              form.control('email').touched && form.control('email').invalid
                  ? 'Please enter a valid email.'
                  : null,
        ),
        SFMainButton(
          label: 'Submit',
          onPressed: () {
            form.markAllAsTouched();
            setState(() {});

            if (form.valid) {
              widget.onSubmit?.call(form.value);
            }
          },
          size: widget.size,
        ),
      ],
    );
  }
}
