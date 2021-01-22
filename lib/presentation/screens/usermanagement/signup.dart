import 'package:aussie/models/usermanagement/signup_model/signup_model.dart';
import 'package:aussie/presentation/screens/feed/feed.dart';
import 'package:aussie/state/single_image_picking/cubit/single_image_picking_cubit.dart';
import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(getTranslation(context, "signup2ButtonText")),
      ),
      body: FormBlocListener<SignupBloc, String, String>(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _SignupProfileImage(profileImage: profileImage),
              TextFieldBlocBuilder(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                textFieldBloc: getSignupBloc(context).fullName,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person_pin),
                  border: InputBorder.none,
                  filled: true,
                  hintText:
                      getTranslation(context, "signupScreenFullNameTitle"),
                ),
              ),
              const SizedBox(height: 10),
              TextFieldBlocBuilder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                ),
                textFieldBloc: getSignupBloc(context).userName,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  border: InputBorder.none,
                  filled: true,
                  hintText:
                      getTranslation(context, "signupScreenUsernameTitle"),
                ),
              ),
              const SizedBox(height: 10),
              TextFieldBlocBuilder(
                textFieldBloc: getSignupBloc(context).email,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                ),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  border: InputBorder.none,
                  filled: true,
                  hintStyle: TextStyle(fontSize: 60.ssp),
                  hintText: getTranslation(context, "signupScreenEmailTitle"),
                ),
              ),
              const SizedBox(height: 10),
              TextFieldBlocBuilder(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                textFieldBloc: getSignupBloc(context).password,
                suffixButton: SuffixButton.obscureText,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  border: InputBorder.none,
                  filled: true,
                  hintStyle: TextStyle(fontSize: 60.ssp),
                  hintText:
                      getTranslation(context, "signupScreenPasswordTitle"),
                ),
              ),
              const SizedBox(height: 10),
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
                              child: const FeedScreen(),
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
                    child = const CircularProgressIndicator();
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: OutlinedButton(
                  onPressed: () {
                    // ignore: close_sinks
                    final signupBloc = getSignupBloc(context);
                    FocusManager.instance.primaryFocus.unfocus();
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
                    //style: const TextStyle(fontSize: 50.ssp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignupProfileImage extends StatelessWidget {
  final ValueNotifier<String> profileImage;

  const _SignupProfileImage({Key key, this.profileImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<SingleImagePickingCubit>().pickImage(
              cropStyle: CropStyle.rectangle,
              maxWidth: 100,
              maxHeight: 100,
              aspectRatio: const CropAspectRatio(ratioX: .5, ratioY: .5),
            );
      },
      child: BlocConsumer<SingleImagePickingCubit, SingleImagePickingState>(
        listener: (context, state) {
          if (state is SingleImagePickingDone) {
            profileImage.value = state.path;
          }
        },
        builder: (context, state) {
          if (state is SingleImagePickingInitial ||
              state is SingleImagePickingError) {
            return Icon(
              Icons.person,
              size: 600.ssp,
            );
          } else if (state is SingleImagePickingDone) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 250,
                width: 250,
                child: Ink.image(
                  fit: BoxFit.fill,
                  image: MemoryImage(
                    state.data.byteData.buffer.asUint8List(),
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
