import 'package:evento/presentation/screens/usermanagement/registeration/first_screen/first_registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InitialUserActionScreen extends HookConsumerWidget {
  const InitialUserActionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: EmailSignInForm(),
    );
  }
}

class EmailSignInForm extends HookConsumerWidget {
  const EmailSignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SignInScreen(
      providerConfigs: const [
        EmailProviderConfiguration(),
      ],
      subtitleBuilder: (context, _) {
        return Row(
          children: [
            const Text("Don't have an account? "),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const FirstRegistrationScreen();
                    },
                  ),
                );
              },
              child: const Text('Register'),
            ),
          ],
        );
      },
      showAuthActionSwitch: false,
    );
  }
}
