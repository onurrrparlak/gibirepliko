import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class RatingDialog extends StatelessWidget {
  const RatingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Uygulamamızı beğendiniz mi?"),
      content: Text("Lütfen bize Play Store üzerinden puan verin"),
      actions: <Widget>[
        ElevatedButton(
          child: Text("İptal"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text("Puan ver"),
          onPressed: () async {
            final url =
                "https://example.com/rate"; // replace with your app store link
            if (await canLaunchUrlString(url)) {
              await launchUrlString(url);
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
