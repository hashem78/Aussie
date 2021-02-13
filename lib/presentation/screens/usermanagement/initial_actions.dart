import 'package:aussie/models/usermanagement/signin_model/signin_model.dart';
import 'package:aussie/presentation/screens/feed/feed.dart';
import 'package:aussie/presentation/screens/usermanagement/signup.dart';
import 'package:aussie/state/language/cubit/language_cubit.dart';
import 'package:aussie/state/single_image_picking/cubit/single_image_picking_cubit.dart';
import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InitialUserActionScreen extends StatefulWidget {
  @override
  _InitialUserActionScreenState createState() =>
      _InitialUserActionScreenState();
}

class _InitialUserActionScreenState extends State<InitialUserActionScreen>
    with TickerProviderStateMixin {
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
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Aussie"),
          actions: [
            IconButton(
              icon: const Icon(Icons.translate),
              onPressed: () {
                toggleLanguage(
                  context,
                  context.read<LanguageCubit>().locale.languageCode,
                );
              },
            ),
          ],
        ),
        key: sstate,
        body: BlocListener<UserManagementCubit, UserManagementState>(
          listener: (context, state) {
            if (state is UserManagementSignin) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => UserManagementCubit()..getUserData(),
                    child: const FeedScreen(),
                  ),
                ),
              );
            }
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: .2.sh,
                        width: .2.sh,
                        color: Colors.red,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextField(
                            controller: _emailEditingController,
                            decoration: InputDecoration(
                              hintText: getTranslation(
                                  context, "initialActionsEmailTitle"),
                              hintStyle: TextStyle(fontSize: 80.sp),
                              prefixIcon: const Icon(Icons.login),
                              filled: true,
                              border: InputBorder.none,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextField(
                              obscureText: true,
                              controller: _passwordEditingController,
                              decoration: InputDecoration(
                                hintText: getTranslation(
                                    context, "initialActionsPasswordTitle"),
                                hintStyle: TextStyle(fontSize: 80.sp),
                                prefixIcon: const Icon(Icons.lock),
                                filled: true,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          BlocBuilder<UserManagementCubit, UserManagementState>(
                            builder: (context, state) {
                              Widget child;

                              if (state is UserManagementPerformingAction) {
                                child = const CircularProgressIndicator();
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
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildSignupButton() {
    return TextButton(
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(),
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return BlocProvider(
                create: (context) => SingleImagePickingCubit(),
                child: SingupScreen(),
              );
            },
          ),
        );
      },
      child: Text(
        getTranslation(context, "signupButtonText"),
        style: TextStyle(fontSize: 85.ssp),
      ),
    );
  }

  Widget buildSigninButton() {
    return TextButton(
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
      child: Text(
        getTranslation(context, "signinButtonText"),
        style: TextStyle(fontSize: 85.ssp),
      ),
    );
  }
}
