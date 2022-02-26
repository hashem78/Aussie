import 'package:evento/presentation/screens/usermanagement/registeration/first_screen/widgets/first_screen_continue_button.dart';
import 'package:evento/presentation/screens/usermanagement/registeration/first_screen/widgets/first_screen_image_picking.dart';
import 'package:evento/presentation/screens/usermanagement/registeration/first_screen/widgets/first_screen_subtitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
                    const FirstRegistrationScreenHeader(),
                    FirstRegistrationScreenImagePickingWidget(
                      showProfilePictureError: showProfilePictureError,
                    ),
                    TextFormField(
                      controller: userNameController,
                      decoration: const InputDecoration(
                        hintText: 'User name',
                        prefixIcon: Icon(Icons.account_circle),
                      ),
                      validator: (val) => RequiredValidator(
                        errorText: 'This Field is required',
                      ).call(val),
                    ),
                    TextFormField(
                      controller: fullNameController,
                      decoration: const InputDecoration(
                        hintText: 'Full name',
                        prefixIcon: Icon(Icons.password),
                      ),
                      validator: (val) => RequiredValidator(
                        errorText: 'This Field is required',
                      ).call(val),
                    ),
                    FirstRegistrationScreenContinueButton(
                      formKey: _formKey,
                      showProfilePictureError: showProfilePictureError,
                      userNameController: userNameController,
                      fullNameController: fullNameController,
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
