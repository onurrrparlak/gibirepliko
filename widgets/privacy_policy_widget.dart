import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/texts/gizlilik_turkce.txt');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Gizlilik, Politikalar ve Telif Hakkı'),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(15, 30, 15, 15),
          child: SingleChildScrollView(
            child: Container(
              child: FutureBuilder(
                future: loadAsset(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    return Center(child: Text(snapshot.data ?? ''));
                  } else {
                    return CircularProgressIndicator(); // or any other loading indicator
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
