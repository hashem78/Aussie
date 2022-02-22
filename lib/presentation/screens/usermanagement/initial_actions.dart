import 'package:aussie/presentation/screens/feed/feed.dart';
import 'package:aussie/providers/providers.dart';
import 'package:aussie/repositories/user_management_repository.dart';
import 'package:aussie/state/image_picking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';

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
        // GoogleProviderConfiguration(
        //   clientId: String.fromEnvironment('ACLIENTID'),
        // ),
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

class FirstRegistrationScreen extends HookConsumerWidget {
  const FirstRegistrationScreen({Key? key}) : super(key: key);
  static final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userNameController = useTextEditingController();
    final fullNameController = useTextEditingController();
    final showProfilePictureError = useValueNotifier(false);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Wrap(
                  runSpacing: 30,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: TextStyle(fontSize: 130.sp),
                        ),
                        Row(
                          children: [
                            const Text(
                              'Already have an account?',
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Sign In'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        if (useValueListenable(showProfilePictureError))
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'Choose a profile picture',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          )
                        else
                          const SizedBox(),
                        GestureDetector(
                          onTap: () {
                            ref
                                .read(imagePickerProvier(PickerUse.signup)
                                    .notifier)
                                .pick(
                                  PickingMode.single,
                                  shouldCrop: true,
                                  cropStyle: CropStyle.circle,
                                );
                            showProfilePictureError.value = ref
                                .read(imagePickerProvier(PickerUse.signup))
                                .when(
                                  picked: (_) => true,
                                  notPicked: (() => false),
                                  error: (() => false),
                                );
                          },
                          child: const SignUpProfileImagePickerWidget(),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: userNameController,
                      decoration: const InputDecoration(hintText: 'User name'),
                      validator: (val) => RequiredValidator(
                        errorText: 'This Field is required',
                      ).call(val),
                    ),
                    TextFormField(
                      controller: fullNameController,
                      decoration: const InputDecoration(hintText: 'Full name'),
                      validator: (val) => RequiredValidator(
                        errorText: 'This Field is required',
                      ).call(val),
                    ),
                    SizedBox(
                      width: 1.sw,
                      child: OutlinedButton(
                        onPressed: () {
                          final isValid = _formKey.currentState!.validate();
                          if (!showProfilePictureError.value) {
                            showProfilePictureError.value = true;
                          }
                          if (isValid && showProfilePictureError.value) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => SecondRegistartionScreen(
                                  username: userNameController.text,
                                  fullname: fullNameController.text,
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text('Continue'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SecondRegistartionScreen extends HookConsumerWidget {
  final String username;
  final String fullname;

  const SecondRegistartionScreen({
    Key? key,
    required this.username,
    required this.fullname,
  }) : super(key: key);
  static final _formKey = GlobalKey<FormState>();
  static final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
    PatternValidator(
      r'(?=.*?[#?!@$%^&*-])',
      errorText: 'Passwords must have at least one special character',
    )
  ]);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final passwordConfirmationController = useTextEditingController();

    return GestureDetector(
      onTap: () {
        print('jere');
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(fontSize: 130.sp),
                      ),
                      const Padding(
                        padding: EdgeInsetsDirectional.only(top: 8.0),
                        child: Text(
                          'Continue your registration process',
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (val) => EmailValidator(
                      errorText: 'Please specify a valid email address',
                    ).call(val),
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: passwordValidator,
                    obscureText: true,
                  ),
                  TextFormField(
                    controller: passwordConfirmationController,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                    ),
                    obscureText: true,
                    validator: (val) => MatchValidator(
                      errorText: 'Passwords do not match!',
                    ).validateMatch(
                      val!,
                      passwordController.text,
                    ),
                  ),
                  SizedBox(
                    width: 1.sw,
                    child: OutlinedButton(
                      onPressed: () async {
                        final isValid = _formKey.currentState!.validate();

                        if (isValid) {
                          final profileImagePath = ref
                              .read(imagePickerProvier(PickerUse.signup))
                              .mapOrNull(
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
                                      overrides: [
                                        scopedUserProvider
                                            .overrideWithValue(user)
                                      ],
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

class SignUpProfileImagePickerWidget extends ConsumerWidget {
  const SignUpProfileImagePickerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileImage = ref.watch(imagePickerProvier(PickerUse.signup));

    return Center(
      child: CircleAvatar(
        radius: 90,
        child: profileImage.whenOrNull(
          picked: (images) {
            return Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: MemoryImage(images.first.byteData),
                  fit: BoxFit.fill,
                ),
              ),
            );
          },
          notPicked: () {
            return const Icon(
              Icons.account_circle,
              size: 180,
            );
          },
        )!,
      ),
    );
  }
}
