import 'package:aussie/aussie_imports.dart';
import 'package:aussie/presentation/screens/feed/feed.dart';

class SingupScreen extends StatelessWidget {
  final ValueNotifier<String> profileImage = ValueNotifier<String>('');

  SingupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: AppBar(
          elevation: 0,
          title: Text(getTranslation(context, 'signup2ButtonText')),
        ),
      ),
      body: FormBlocListener<SignupBloc, String, String>(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _SignupProfileImage(profileImage: profileImage),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextFieldBlocBuilder(
                          textFieldBloc: getSignupBloc(context).fullName,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person_pin),
                            border: InputBorder.none,
                            filled: true,
                            hintText: getTranslation(
                                context, 'signupScreenFullNameTitle'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFieldBlocBuilder(
                          textFieldBloc: getSignupBloc(context).userName,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            border: InputBorder.none,
                            filled: true,
                            hintText: getTranslation(
                                context, 'signupScreenUsernameTitle'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFieldBlocBuilder(
                          textFieldBloc: getSignupBloc(context).email,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
                            border: InputBorder.none,
                            filled: true,
                            hintStyle: TextStyle(fontSize: 60.sp),
                            hintText: getTranslation(
                                context, 'signupScreenEmailTitle'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFieldBlocBuilder(
                          textFieldBloc: getSignupBloc(context).password,
                          suffixButton: SuffixButton.obscureText,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            border: InputBorder.none,
                            filled: true,
                            hintStyle: TextStyle(fontSize: 60.sp),
                            hintText: getTranslation(
                                context, 'signupScreenPasswordTitle'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        BlocConsumer<UMCubit, UMCState>(
                          listener: (BuildContext context, UMCState state) {
                            if (state is UMCSignup) {
                              Future<void>.delayed(const Duration(seconds: 2))
                                  .whenComplete(
                                () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute<FeedScreen>(
                                      builder: (BuildContext context) {
                                        return BlocProvider<UMCubit>(
                                          create: (BuildContext context) {
                                            return UMCubit()..getUserData();
                                          },
                                          child: const FeedScreen(),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            }
                          },
                          builder: (BuildContext context, UMCState state) {
                            Widget? child;

                            if (state is UMCPerformingAction) {
                              child = const CircularProgressIndicator();
                            } else if (state is UMCError) {
                              child = Text(
                                state.notification!.message,
                                style: const TextStyle(color: Colors.red),
                              );
                            } else if (state is UMCSignup) {
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
                        TextButton(
                          onPressed: () {
                            // ignore: close_sinks
                            final SignupBloc signupBloc =
                                getSignupBloc(context);
                            FocusManager.instance.primaryFocus!.unfocus();
                            signupBloc.submit();
                            BlocProvider.of<UMCubit>(context).signup(
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
                            getTranslation(context, 'signup2ButtonText'),
                            style: TextStyle(fontSize: 85.sp),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SignupProfileImage extends StatelessWidget {
  final ValueNotifier<String?>? profileImage;

  const _SignupProfileImage({Key? key, this.profileImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<SingleImagePickingCubit>().pickImage(
              cropStyle: CropStyle.rectangle,
              maxWidth: 500,
              maxHeight: 500,
              quality: 95,
              aspectRatio: const CropAspectRatio(ratioX: .5, ratioY: .5),
            );
      },
      child: BlocConsumer<SingleImagePickingCubit, SingleImagePickingState>(
        listener: (BuildContext context, SingleImagePickingState state) {
          if (state is SingleImagePickingDone) {
            profileImage!.value = state.path;
          }
        },
        builder: (BuildContext context, SingleImagePickingState state) {
          if (state is SingleImagePickingInitial ||
              state is SingleImagePickingError) {
            return Icon(
              Icons.person,
              size: 600.sp,
            );
          } else if (state is SingleImagePickingDone) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 250,
                width: 250,
                child: Ink.image(
                  fit: BoxFit.cover,
                  image: MemoryImage(
                    state.data!.byteData!.buffer.asUint8List(),
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
