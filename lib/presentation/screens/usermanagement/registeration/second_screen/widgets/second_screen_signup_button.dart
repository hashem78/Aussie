import 'package:evento/presentation/screens/feed/feed_screen.dart';
import 'package:evento/repositories/user_management_repository.dart';
import 'package:evento/state/image_picking.dart';
import 'package:evento/state/user_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SecondRegistartionScreenSignUpButton extends HookConsumerWidget {
  const SecondRegistartionScreenSignUpButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.emailController,
    required this.passwordController,
    required this.username,
    required this.fullname,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String username;
  final String fullname;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 1.sw,
      child: OutlinedButton(
        onPressed: () async {
          final isValid = _formKey.currentState!.validate();

          if (isValid) {
            final profileImagePath =
                ref.read(imagePickerProvier(PickerUse.signup)).mapOrNull(
                      picked: ((value) => value.images.first.path),
                    )!;
            final state = await UMRepository.signup(
              email: emailController.text,
              password: passwordController.text,
              profileImagePath: profileImagePath,
              username: username,
              fullname: fullname,
            );
            state.whenOrNull(
              goodSignup: (user) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ProviderScope(
                        overrides: [scopedUserProvider.overrideWithValue(user)],
                        child: const FeedScreen(),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
        child: const Text('Sign Up'),
      ),
    );
  }
}
