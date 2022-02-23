import 'package:aussie/presentation/screens/usermanagement/registeration/second_screen/widgets/second_screen_signup_button.dart';
import 'package:aussie/presentation/screens/usermanagement/registeration/second_screen/widgets/second_screen_subtitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SecondRegistartionScreen extends HookConsumerWidget {
  final String username;
  final String fullname;

  const SecondRegistartionScreen({
    Key? key,
    required this.username,
    required this.fullname,
  }) : super(key: key);
  static final _formKey = GlobalKey<FormState>();
  static final passwordValidator = MultiValidator(
    [
      RequiredValidator(errorText: 'Password is required'),
      MinLengthValidator(8,
          errorText: 'Password must be at least 8 digits long'),
      PatternValidator(
        r'(?=.*?[#?!@$%^&*-])',
        errorText: 'Passwords must have at least one special character',
      )
    ],
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final passwordConfirmationController = useTextEditingController();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Wrap(
                runSpacing: 30,
                children: [
                  const SecondRegistrationScreenSubTitle(),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (val) => EmailValidator(
                      errorText: 'Please specify a valid email address',
                    ).call(val),
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.password),
                    ),
                    validator: passwordValidator,
                    obscureText: true,
                  ),
                  TextFormField(
                    controller: passwordConfirmationController,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.password),
                    ),
                    obscureText: true,
                    validator: (val) => MatchValidator(
                      errorText: 'Passwords do not match!',
                    ).validateMatch(
                      val!,
                      passwordController.text,
                    ),
                  ),
                  SecondRegistartionScreenSignUpButton(
                    formKey: _formKey,
                    emailController: emailController,
                    passwordController: passwordController,
                    username: username,
                    fullname: fullname,
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
