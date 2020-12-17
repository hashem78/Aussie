import 'package:aussie/models/usermanagement/signin_model/signin_model.dart';
import 'package:aussie/presentation/screens/feed/feed.dart';
import 'package:aussie/presentation/screens/usermanagement/signup.dart';
import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animations/loading_animations.dart';

class InitialUserActionScreen extends StatefulWidget {
  @override
  _InitialUserActionScreenState createState() =>
      _InitialUserActionScreenState();
}

class _InitialUserActionScreenState extends State<InitialUserActionScreen> {
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
    ScreenUtil.init(context);
    return SafeArea(
      child: Scaffold(
        key: sstate,
        body: BlocListener<UserManagementCubit, UserManagementState>(
          listener: (context, state) {
            if (state is UserManagementSignin) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => FeedScreen(),
                ),
              );
            }
          },
          child: Center(
            child: SingleChildScrollView(
              child: Column(
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

                      if (state is UserManagementPerformingAction)
                        child = LoadingBouncingGrid.square();
                      else if (state is UserManagementError) {
                        child = Text(
                          state.notification.message,
                          textAlign: TextAlign.center,
                        );
                      }
                      return AnimatedSwitcher(
                        duration: Duration(milliseconds: 500),
                        child: Center(child: child),
                      );
                    },
                  ),
                  buildSigninButton(),
                  buildSignupButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding buildTextFields() {
    return Padding(
      padding: EdgeInsets.all(.05.sw),
      child: Column(
        children: [
          TextField(
            controller: _emailEditingController,
            decoration: InputDecoration(
              hintText: "Email",
              hintStyle: TextStyle(fontSize: 40.sp),
              icon: Icon(Icons.login),
              filled: true,
              border: InputBorder.none,
            ),
          ),
          SizedBox(
            height: .05.sh,
          ),
          TextField(
            obscureText: true,
            controller: _passwordEditingController,
            decoration: InputDecoration(
              hintText: "Password",
              hintStyle: TextStyle(fontSize: 40.sp),
              icon: Icon(Icons.lock),
              filled: true,
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }

  TextButton buildSignupButton(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SingupScreen(),
          ),
        );
      },
      child: Text("Sign up for an account"),
    );
  }

  OutlineButton buildSigninButton() {
    return OutlineButton(
      onPressed: () {
        BlocProvider.of<UserManagementCubit>(context).singin(
          SigninModel(
            _emailEditingController.text,
            _passwordEditingController.text,
          ),
        );
        // _emailEditingController.clear();
        _passwordEditingController.clear();
      },
      child: Text("Sign in"),
    );
  }
}
