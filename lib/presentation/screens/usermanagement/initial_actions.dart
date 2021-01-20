import 'package:aussie/models/usermanagement/signin_model/signin_model.dart';
import 'package:aussie/presentation/screens/feed/feed.dart';
import 'package:aussie/presentation/screens/usermanagement/signup.dart';
import 'package:aussie/state/single_image_picking/cubit/single_image_picking_cubit.dart';
import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

class InitialUserActionScreen extends StatefulWidget {
  @override
  _InitialUserActionScreenState createState() =>
      _InitialUserActionScreenState();
}

class _InitialUserActionScreenState extends State<InitialUserActionScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> sstate = GlobalKey();

  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  @override
  void dispose() {
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus.unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          key: sstate,
          body: BlocListener<UserManagementCubit, UserManagementState>(
            listener: (context, state) {
              if (state is UserManagementSignin) {
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    child: BlocProvider(
                      create: (context) => UserManagementCubit()..getUserData(),
                      child: FeedScreen(),
                    ),
                    type: getAppropriateAnimation(context),
                  ),
                );
              }
            },
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: .2.sh,
                      width: .2.sh,
                      color: Colors.red,
                    ),
                    buildTextFields(),
                    BlocBuilder<UserManagementCubit, UserManagementState>(
                      builder: (context, state) {
                        Widget child;

                        if (state is UserManagementPerformingAction) {
                          child = getIndicator(context);
                        } else {
                          if (state is UserManagementError) {
                            child = Text(
                              state.notification.message,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.red),
                            );
                          }
                        }
                        return AnimatedSize(
                          duration: const Duration(milliseconds: 500),
                          vsync: this,
                          child: Center(child: child),
                        );
                      },
                    ),
                    buildSigninButton(),
                    buildSignupButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextFields() {
    return Padding(
      padding: EdgeInsets.all(.05.sw),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _emailEditingController,
              decoration: InputDecoration(
                hintText: getTranslation(context, "initialActionsEmailTitle"),
                hintStyle: TextStyle(fontSize: 80.sp),
                icon: const Icon(Icons.login),
                filled: true,
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: .05.sh,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              obscureText: true,
              controller: _passwordEditingController,
              decoration: InputDecoration(
                hintText:
                    getTranslation(context, "initialActionsPasswordTitle"),
                hintStyle: TextStyle(fontSize: 80.sp),
                icon: const Icon(Icons.lock),
                filled: true,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSignupButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64.0),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: const RoundedRectangleBorder(),
        ),
        onPressed: () {
          Navigator.of(context)
              .push(
                PageTransition(
                  child: SingupScreen(),
                  type: getAppropriateAnimation(context),
                ),
              )
              .whenComplete(
                () => context.read<SingleImagePickingCubit>().emitInitial(),
              );
        },
        child: Text(getTranslation(context, "signupButtonText")),
      ),
    );
  }

  Widget buildSigninButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 64.0),
      child: TextButton(
        onPressed: () {
          BlocProvider.of<UserManagementCubit>(context).singin(
            SigninModel(
              _emailEditingController.text,
              _passwordEditingController.text,
            ),
          );
          // _emailEditingController.clear();
          _passwordEditingController.clear();
          FocusManager.instance.primaryFocus.unfocus();
        },
        child: Text(getTranslation(context, "signinButtonText")),
      ),
    );
  }
}
