import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class SFAuthView extends StatefulWidget {
  final Map<String, dynamic> additionalData;

  const SFAuthView({super.key, this.additionalData = const {}});

  @override
  State<SFAuthView> createState() => SFAuthViewState();
}

class SFAuthViewState extends State<SFAuthView> {
  final PageController _pageController = PageController();
  final Map<String, dynamic> additionalData = {
    'label_email': 'E-mail',
    'placeholder_email': 'Enter your email',
    'error_email_invalid': 'Invalid email address.',
    'label_password': 'Password',
    'placeholder_password': 'Enter your password',
    'error_password_length': 'Password must be at least 6 characters.',
    'login_button': 'Login',
    'auth_not_account': {
      'text': 'Don\'t have an account yet? ',
      'link': 'Create an account',
    },
    'auth_forgot_password': {'link': 'Forgot password'},
    'auth_already_exists': {
      'text': 'Already have an account? ',
      'link': 'Login',
    },
  };

  @override
  void initState() {
    super.initState();

    // merge additionalData with widget.additionalData
    if (widget.additionalData.isNotEmpty) {
      additionalData.addAll(widget.additionalData);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _richText({String? text, required String link, Function? onTap}) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          if (text != null) TextSpan(text: text),
          TextSpan(
            text: link,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).primaryColor,
            ),
            recognizer:
                onTap != null
                    ? (TapGestureRecognizer()..onTap = () => onTap())
                    : null,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Column(
          spacing: AppSpacing.md,
          children: [
            SFLoginForm(additionalData: additionalData),
            _richText(
              text:
                  additionalData['auth_not_account']?['text'] ??
                  'Don\'t have an account yet?',
              link:
                  additionalData['auth_not_account']?['link'] ??
                  'Create an account',
              onTap: () {
                _pageController.jumpToPage(1);
              },
            ),
            _richText(
              link:
                  additionalData['auth_forgot_password']?['link'] ??
                  'Forgot password',
              onTap: () {
                _pageController.jumpToPage(2);
              },
            ),
          ],
        ),
        Column(
          spacing: AppSpacing.md,
          children: [
            SFRegisterForm(additionalData: additionalData),
            _richText(
              text: additionalData['auth_already_exists']?['text'],
              link: additionalData['auth_already_exists']?['link'],
              onTap: () {
                _pageController.jumpToPage(0);
              },
            ),
          ],
        ),
        Column(
          spacing: AppSpacing.md,
          children: [
            SFForgotPasswordForm(additionalData: additionalData),
            _richText(
              text: additionalData['auth_already_exists']?['text'],
              link: additionalData['auth_already_exists']?['link'],
              onTap: () {
                _pageController.jumpToPage(0);
              },
            ),
          ],
        ),
      ],
    );
  }
}
