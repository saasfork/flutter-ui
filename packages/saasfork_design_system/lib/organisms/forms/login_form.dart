import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class SFLoginForm extends StatefulWidget {
  final ComponentSize size;
  final double spacing;
  final Function(Map<String, dynamic>)? onSubmit;

  const SFLoginForm({
    super.key,
    this.onSubmit,
    this.size = ComponentSize.md,
    this.spacing = AppSpacing.sm,
  });

  @override
  State<SFLoginForm> createState() => _SFLoginFormState();
}

class _SFLoginFormState extends State<SFLoginForm> {
  final form = FormGroup({
    'email': FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
    'password': FormControl<String>(
      validators: [Validators.required, Validators.minLength(6)],
    ),
  });

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: form.control('email').value);
    _passwordController = TextEditingController(
      text: form.control('password').value,
    );

    _emailController.addListener(() {
      form.control('email').value = _emailController.text;
    });

    _passwordController.addListener(() {
      form.control('password').value = _passwordController.text;
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
        SFFormfield(
          isRequired: form
              .control('password')
              .validators
              .any((validator) => validator == Validators.required),
          label: 'Password',
          input: SFPasswordField(
            placeholder: 'Enter your password',
            controller: _passwordController,
            size: widget.size,
            isInError:
                form.control('password').touched &&
                form.control('password').invalid,
          ),
          errorMessage:
              form.control('password').touched &&
                      form.control('password').invalid
                  ? 'Password must be at least 6 characters long.'
                  : null,
        ),
        SFMainButton(
          label: 'Login',
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
