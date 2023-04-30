import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class ShareAppWidget extends StatelessWidget {
  String playStoreLink =
      'https://play.google.com/store/apps/details?id=com.yourapp.package';
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.share),
      title: Text('Uygulamayı paylaş'),
      onTap: () {
        Share.share(
            'Gibi Replikleri uygulamasını hemen indir! : $playStoreLink');
      },
    );
  }
}
