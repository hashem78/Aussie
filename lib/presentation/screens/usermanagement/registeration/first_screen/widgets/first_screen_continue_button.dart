import 'package:evento/presentation/screens/usermanagement/registeration/second_screen/second_registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FirstRegistrationScreenContinueButton extends StatelessWidget {
  const FirstRegistrationScreenContinueButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.showProfilePictureError,
    required this.userNameController,
    required this.fullNameController,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final ValueNotifier<bool> showProfilePictureError;
  final TextEditingController userNameController;
  final TextEditingController fullNameController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: OutlinedButton(
        onPressed: () {
          final isValid = _formKey.currentState!.validate();
          if (!showProfilePictureError.value) {
            showProfilePictureError.value = true;
          }
          if (isValid && showProfilePictureError.value) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SecondRegistartionScreen(
                  username: userNameController.text,
                  fullname: fullNameController.text,
                ),
              ),
            );
          }
        },
        child: const Text('Continue'),
      ),
    );
  }
}
