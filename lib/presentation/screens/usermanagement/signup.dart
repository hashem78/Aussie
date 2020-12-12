import 'dart:io';

import 'package:aussie/models/usermanagement/signup_model/signup_model.dart';
import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class SingupScreen extends StatefulWidget {
  @override
  _SingupScreenState createState() => _SingupScreenState();
}

class _SingupScreenState extends State<SingupScreen> {
  final ValueNotifier<String> profileImage = ValueNotifier("");
  final UserManagementCubit cubit = UserManagementCubit();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Signup"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _SignupProfileImage(profileImage: profileImage),
              SizedBox(height: .08.sh),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    border: InputBorder.none,
                    filled: true,
                    hintText: "Email",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    border: InputBorder.none,
                    filled: true,
                    hintText: "Password",
                  ),
                ),
              ),
              BlocConsumer<UserManagementCubit, UserManagementState>(
                cubit: cubit,
                listener: (context, state) {
                  if (state is UserManagementSignup) {
                    Future.delayed(Duration(seconds: 2)).whenComplete(
                      () => Navigator.of(context).pop(),
                    );
                  }
                },
                builder: (context, state) {
                  Widget child;
                  if (state is UserManagementPerformingAction)
                    child = CircularProgressIndicator();
                  else if (state is UserManagementSignupError)
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
                  cubit.signup(
                    SignupModel(
                      _email.text,
                      _password.text,
                      profileImage.value,
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
