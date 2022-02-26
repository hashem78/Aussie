import 'package:evento/repositories/user_management_repository.dart';
import 'package:evento/util/functions.dart';
import 'package:flutter/material.dart';

class SignoutTile extends StatelessWidget {
  const SignoutTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        await UMRepository.signout();
      },
      leading: const Icon(Icons.unsubscribe),
      title: Text(
        getTranslation(context, 'signoutTileTitle'),
      ),
    );
  }
}
