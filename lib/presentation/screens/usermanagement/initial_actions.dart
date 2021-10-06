import 'package:aussie/aussie_imports.dart';
import 'package:aussie/presentation/screens/feed/feed.dart';

class InitialUserActionScreen extends StatefulWidget {
  const InitialUserActionScreen({Key? key}) : super(key: key);

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
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        drawer: const AussieAppDrawer(),
        appBar: PreferredSize(
            preferredSize: const Size(double.infinity, kToolbarHeight),
            child: AppBar(
              title: const Text('Aussie'),
              actions: <Widget>[
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
            )),
        key: sstate,
        body: BlocListener<UserManagementCubit, UserManagementState>(
          listener: (BuildContext context, UserManagementState state) {
            if (state is UserManagementSignin) {
              Navigator.push(
                context,
                MaterialPageRoute<FeedScreen>(
                  builder: (BuildContext context) {
                    return BlocProvider<UserManagementCubit>(
                      create: (BuildContext context) {
                        return UserManagementCubit()..getUserData();
                      },
                      child: const FeedScreen(),
                    );
                  },
                ),
              );
            }
          },
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        height: .2.sh,
                        width: .2.sh,
                        color: Colors.red,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          TextField(
                            controller: _emailEditingController,
                            decoration: InputDecoration(
                              hintText: getTranslation(
                                  context, 'initialActionsEmailTitle'),
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
                                    context, 'initialActionsPasswordTitle'),
                                hintStyle: TextStyle(fontSize: 80.sp),
                                prefixIcon: const Icon(Icons.lock),
                                filled: true,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          BlocBuilder<UserManagementCubit, UserManagementState>(
                            builder: (BuildContext context,
                                UserManagementState state) {
                              Widget? child;

                              if (state is UserManagementPerformingAction) {
                                child = const CircularProgressIndicator();
                              } else {
                                if (state is UserManagementError) {
                                  child = Text(
                                    state.notification!.message,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.red),
                                  );
                                }
                              }
                              return AnimatedSize(
                                duration: const Duration(milliseconds: 500),
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
          MaterialPageRoute<SingupScreen>(
            builder: (BuildContext context) {
              return MultiBlocProvider(
                providers: <BlocProvider<Object?>>[
                  BlocProvider<SingleImagePickingCubit>(
                    create: (BuildContext context) => SingleImagePickingCubit(),
                  ),
                  BlocProvider<UserManagementCubit>(
                    create: (BuildContext context) => UserManagementCubit(),
                  ),
                  BlocProvider<SignupBloc>(
                    create: (BuildContext context) => SignupBloc(),
                  )
                ],
                child: SingupScreen(),
              );
            },
          ),
        );
      },
      child: Text(
        getTranslation(context, 'signupButtonText'),
        style: TextStyle(fontSize: 85.sp),
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
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Text(
        getTranslation(context, 'signinButtonText'),
        style: TextStyle(fontSize: 85.sp),
      ),
    );
  }
}
