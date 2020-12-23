import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';

class AboutAussieTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(5),
      onTap: () {
        showAboutDialog(
          context: context,
          applicationVersion: "1.0",
          applicationName: "Aussie",
          applicationLegalese: getTranslation(context, "legalese"),
        );
      },
      leading: Text(getTranslation(context, "aboutAussieText")),
      trailing: const Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: Icon(Icons.info),
      ),
    );
  }
}
