import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';

class AboutAussieTile extends StatelessWidget {
  const AboutAussieTile();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: ListTile(
        contentPadding: const EdgeInsets.all(5),
        onTap: () {
          showAboutDialog(
            context: context,
            applicationVersion: "1.0",
            applicationName: "Aussie",
            applicationLegalese: getTranslation(context, "legalese"),
          );
        },
        leading: Text(getTranslation(context, "aboutAussieText")!),
        trailing: const Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: Icon(Icons.info),
        ),
      ),
    );
  }
}
