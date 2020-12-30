import 'dart:io';

import 'package:aussie/models/usermanagement/signup_model/signup_model.dart';
import 'package:aussie/presentation/screens/feed/feed.dart';
import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

class SignupBloc extends FormBloc<String, String> {
  final fullName = TextFieldBloc(validators: [FieldBlocValidators.required]);
  final userName = TextFieldBloc(validators: [FieldBlocValidators.required]);
  final email = TextFieldBloc(
    validators: [FieldBlocValidators.required, FieldBlocValidators.email],
  );
  final password = TextFieldBloc(validators: [
    FieldBlocValidators.required,
    FieldBlocValidators.passwordMin6Chars
  ]);

  SignupBloc() {
    addFieldBlocs(fieldBlocs: [
      fullName,
      userName,
      email,
      password,
    ]);
  }
  String profileImagePath;

  @override
  Future<void> onSubmitting() async {}

  @override
  Future<void> onCancelingSubmission() async {}

  @override
  Future<void> onDeleting() async {}

  @override
  Future<void> onLoading() async {}
}

class SingupScreen extends StatelessWidget {
  final ValueNotifier<String> profileImage = ValueNotifier("");

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(getTranslation(context, "signup2ButtonText")),
      ),
      body: FormBlocListener<SignupBloc, String, String>(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _SignupProfileImage(profileImage: profileImage),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFieldBlocBuilder(
                  textFieldBloc: getSignupBloc(context).fullName,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_pin),
                    border: InputBorder.none,
                    filled: true,
                    hintText:
                        getTranslation(context, "signupScreenFullNameTitle"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFieldBlocBuilder(
                  textFieldBloc: getSignupBloc(context).userName,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    border: InputBorder.none,
                    filled: true,
                    hintText:
                        getTranslation(context, "signupScreenUsernameTitle"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFieldBlocBuilder(
                  textFieldBloc: getSignupBloc(context).email,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    border: InputBorder.none,
                    filled: true,
                    hintText: getTranslation(context, "signupScreenEmailTitle"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFieldBlocBuilder(
                  textFieldBloc: getSignupBloc(context).password,
                  suffixButton: SuffixButton.obscureText,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    border: InputBorder.none,
                    filled: true,
                    hintText:
                        getTranslation(context, "signupScreenPasswordTitle"),
                  ),
                ),
              ),
              BlocConsumer<UserManagementCubit, UserManagementState>(
                listener: (context, state) {
                  if (state is UserManagementSignup) {
                    Future.delayed(const Duration(seconds: 2)).whenComplete(
                      () {
                        Navigator.of(context).pushReplacement(
                          PageTransition(
                            child: BlocProvider(
                              create: (context) =>
                                  UserManagementCubit()..getUserData(),
                              child: FeedScreen(),
                            ),
                            type: getAppropriateAnimation(context),
                          ),
                        );
                      },
                    );
                  }
                },
                builder: (context, state) {
                  Widget child;

                  if (state is UserManagementPerformingAction) {
                    child = getIndicator(context);
                  } else if (state is UserManagementError) {
                    child = Text(
                      state.notification.message,
                      style: const TextStyle(color: Colors.red),
                    );
                  } else if (state is UserManagementSignup) {
                    child = Text(
                      state.notification.message,
                      style: const TextStyle(color: Colors.green),
                    );
                  }

                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Center(child: child),
                  );
                },
              ),
              OutlinedButton(
                onPressed: () {
                  // ignore: close_sinks
                  final signupBloc = getSignupBloc(context);
                  signupBloc.submit();
                  BlocProvider.of<UserManagementCubit>(context).signup(
                    SignupModel(
                      email: signupBloc.email.value,
                      password: signupBloc.password.value,
                      profileImagePath: profileImage.value,
                      username: signupBloc.userName.value,
                      fullname: signupBloc.fullName.value,
                    ),
                  );
                },
                child: AutoSizeText(
                  getTranslation(context, "signup2ButtonText"),
                  //style: const TextStyle(fontSize: 50.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignupProfileImage extends StatefulWidget {
  final ValueNotifier<String> profileImage;
  const _SignupProfileImage({
    Key key,
    @required this.profileImage,
  }) : super(key: key);
  @override
  __SignupProfileImageState createState() => __SignupProfileImageState();
}

class __SignupProfileImageState extends State<_SignupProfileImage> {
  final ImagePicker picker = ImagePicker();
  Future<PickedFile> futureProfileImage;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<PickedFile>(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              widget.profileImage.value = snapshot.data.path;

              return Image.file(
                File(snapshot.data.path),
                fit: BoxFit.fill,
              );
            }
            return Icon(
              Icons.person,
              size: 400.sp,
            );
          },
          future: futureProfileImage,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildButton(
              imageSource: ImageSource.gallery,
              iconData: Icons.image,
            ),
            buildButton(
              imageSource: ImageSource.camera,
              iconData: Icons.camera_alt,
            ),
          ],
        ),
      ],
    );
  }

  Widget buildButton({ImageSource imageSource, IconData iconData}) {
    return IconButton(
      onPressed: () async {
        setState(
          () {
            futureProfileImage = picker.getImage(
              source: imageSource,
              maxWidth: 300,
              maxHeight: 300,
            );
          },
        );
      },
      iconSize: 100.sp,
      icon: Icon(iconData),
    );
  }
}
