import 'dart:io';

import 'package:aussie/models/usermanagement/signup_model/signup_model.dart';
import 'package:aussie/presentation/screens/feed/feed.dart';

import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';
import 'package:aussie/util/functions.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animations/loading_animations.dart';

class SignupBloc extends FormBloc<String, String> {
  // ignore: close_sinks
  final fullName = TextFieldBloc(validators: [FieldBlocValidators.required]);
  // ignore: close_sinks
  final userName = TextFieldBloc(validators: [FieldBlocValidators.required]);
  // ignore: close_sinks
  final email = TextFieldBloc(
    validators: [FieldBlocValidators.required, FieldBlocValidators.email],
  );
  // ignore: close_sinks
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
  void onSubmitting() {}
}

class SingupScreen extends StatelessWidget {
  final ValueNotifier<String> profileImage = ValueNotifier("");

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Signup"),
      ),
      body: FormBlocListener<SignupBloc, String, String>(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _SignupProfileImage(profileImage: profileImage),
              SizedBox(height: .08.sh),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFieldBlocBuilder(
                  textFieldBloc: getSignupBloc(context).fullName,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_pin),
                    border: InputBorder.none,
                    filled: true,
                    hintText: "Full name",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFieldBlocBuilder(
                  textFieldBloc: getSignupBloc(context).userName,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    border: InputBorder.none,
                    filled: true,
                    hintText: "Username",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFieldBlocBuilder(
                  textFieldBloc: getSignupBloc(context).email,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    border: InputBorder.none,
                    filled: true,
                    hintText: "Email",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFieldBlocBuilder(
                  textFieldBloc: getSignupBloc(context).password,
                  suffixButton: SuffixButton.obscureText,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    border: InputBorder.none,
                    filled: true,
                    hintText: "Password",
                  ),
                ),
              ),
              BlocConsumer<UserManagementCubit, UserManagementState>(
                listener: (context, state) {
                  if (state is UserManagementSignup)
                    Future.delayed(Duration(seconds: 2)).whenComplete(
                      () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (context) =>
                                  UserManagementCubit()..getUserData(),
                              child: FeedScreen(),
                            ),
                          ),
                        );
                      },
                    );
                },
                builder: (context, state) {
                  Widget child;

                  if (state is UserManagementPerformingAction)
                    child = LoadingBouncingGrid.square();
                  else if (state is UserManagementError)
                    child = Text(
                      "${state.notification.message}",
                      style: TextStyle(color: Colors.red),
                    );
                  else if (state is UserManagementSignup)
                    child = Text(
                      state.notification.message,
                      style: TextStyle(color: Colors.green),
                    );
                  return AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    child: Center(child: child),
                  );
                },
              ),
              OutlineButton(
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
                child: Text("Sign up"),
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
    return Stack(
      overflow: Overflow.visible,
      children: [
        Container(
          width: .6.sw,
          height: .6.sw,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          child: FutureBuilder<PickedFile>(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                widget.profileImage.value = snapshot.data.path;

                return Image.file(
                  File(snapshot.data.path),
                  fit: BoxFit.fill,
                );
              }
              return Container(
                child: Icon(
                  Icons.person,
                  size: 400.sp,
                ),
              );
            },
            future: futureProfileImage,
          ),
        ),
        Positioned(
          bottom: -.02.sh,
          left: -0.02.sh,
          child: buildButton(
            imageSource: ImageSource.gallery,
            iconData: Icons.image,
          ),
        ),
        Positioned(
          bottom: -.02.sh,
          right: -0.02.sh,
          child: buildButton(
            imageSource: ImageSource.camera,
            iconData: Icons.camera_alt,
          ),
        ),
      ],
    );
  }

  Container buildButton({ImageSource imageSource, IconData iconData}) {
    return Container(
      color: Colors.amber,
      child: IconButton(
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
      ),
    );
  }
}
