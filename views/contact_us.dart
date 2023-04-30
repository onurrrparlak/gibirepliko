import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomAlertDialog extends StatelessWidget {
  final String email = 'gibireplikleriapp@gmail.com';

  void _launchEmailApp(BuildContext context) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      // Display an error message if the email app isn't available
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email uygulaması bulunamadı')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Bize ulaşın'),
      content: RichText(
        text: TextSpan(
          text: 'Bizlere ',
          children: [
            TextSpan(
              text: email,
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _launchEmailApp(context);
                },
            ),
            TextSpan(
              text: ' adresinden ulaşabilirsiniz.',
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Tamam'),
        ),
      ],
    );
  }
}
