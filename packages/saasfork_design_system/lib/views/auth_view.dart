import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class SFAuthView extends StatefulWidget {
  const SFAuthView({super.key});

  @override
  State<SFAuthView> createState() => SFAuthViewState();
}

class SFAuthViewState extends State<SFAuthView> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  RichText _richText({String? text, required String link, Function? onTap}) {
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
            SFLoginForm(),
            _richText(
              text: 'Pas encore de compte ? ',
              link: 'Créez un compte',
              onTap: () {
                _pageController.jumpToPage(1);
              },
            ),
            _richText(
              link: 'Mot de passe oublié',
              onTap: () {
                _pageController.jumpToPage(2);
              },
            ),
          ],
        ),
        Column(
          spacing: AppSpacing.md,
          children: [
            SFRegisterForm(),
            _richText(
              text: 'Déjà un compte ? ',
              link: 'Connectez-vous',
              onTap: () {
                _pageController.jumpToPage(0);
              },
            ),
          ],
        ),
        Column(
          spacing: AppSpacing.md,
          children: [
            SFForgotPasswordForm(),
            _richText(
              text: 'Déjà un compte ? ',
              link: 'Connectez-vous',
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
