import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ReplikOner extends StatefulWidget {
  @override
  _ReplikOnerState createState() => _ReplikOnerState();
}

class _ReplikOnerState extends State<ReplikOner> {
  final TextEditingController _replikController = TextEditingController();
  final TextEditingController _neredeGeciyorController =
      TextEditingController();

  void _submitForm() async {
    final String subject = '$_replikController';
    final String body =
        'Replik: ${_replikController.text}\nNerede geçiyor: ${_neredeGeciyorController.text}';
    final String recipient = 'gibireplikleriapp@gmail.com';
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: recipient,
      query: 'subject=$subject&body=$body',
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Başarılı!'),
          content: Text(
              'Maili göndermek için e-posta adresinize yönlendiriliyorsunuz.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Hata'),
          content: Text('Mail adresi açılamadı.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Tamam'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Replik Öner'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Replik'),
            SizedBox(height: 8.0),
            TextFormField(
              decoration: InputDecoration(hintText: 'Repliği giriniz.'),
              controller: _replikController,
            ),
            SizedBox(height: 16.0),
            Text('Nerede geçiyor?'),
            SizedBox(height: 8.0),
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'Hangi sahnede geçtiğini tarif ediniz.'),
              controller: _neredeGeciyorController,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Gönder'),
            ),
          ],
        ),
      ),
    );
  }
}
