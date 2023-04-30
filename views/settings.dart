import 'package:flutter/material.dart';
import 'package:gibirepliko/services/admob_service.dart';
import 'package:gibirepliko/services/audioplayer_service.dart';
import 'package:gibirepliko/views/app_version.dart';
import 'package:gibirepliko/views/contact_us.dart';
import 'package:gibirepliko/views/rate_the_app.dart';
import 'package:gibirepliko/views/replik_oner.dart';
import 'package:gibirepliko/views/share_the_app.dart';
import 'package:gibirepliko/widgets/gibi_izle.dart';
import 'package:gibirepliko/widgets/privacy_policy_widget.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../provider/settings_provider.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late AdMobService _adMobService;
  late AudioService _audioService = AudioService();

  late bool _kufur;

  @override
  void initState() {
    super.initState();
    _adMobService = AdMobService();

    _adMobService.createRewardedAd();
    _loadSettings();

    Provider.of<SettingsProvider>(context, listen: false).loadSettings();
  }

  @override
  void dispose() {
    _adMobService.dispose();
    _audioService.dispose();
    super.dispose();
  }

  void _loadSettings() async {
    final box = await Hive.openBox('settings');
    if (box.containsKey('kufur')) {
      setState(() {
        _kufur = box.get('kufur');
      });
    }
  }

  void _saveSettings() async {
    final box = await Hive.openBox('settings');
    await box.put('kufur', _kufur);
    var switchValue = box.get('kufur');
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      body: Consumer<SettingsProvider>(builder: (context, provider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Ayarlar',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: 8,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(color: Colors.white),
                itemBuilder: (BuildContext context, int index) {
                  switch (index) {
                    case 0:
                      return gibiIzle();
                    case 1:
                      return ListTile(
                        leading: Icon(Icons.mail),
                        title: Text('Bize ulaşın'),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomAlertDialog();
                            },
                          );
                        },
                      );
                    case 2:
                      return ShareAppWidget();
                    case 3:
                      return ListTile(
                        leading: Icon(Icons.money),
                        title: Text('Reklam izleyerek uygulamaya destek ol'),
                        onTap: () async {
                          await Provider.of<AudioService>(context,
                                  listen: false)
                              .stopSound();
                          await Future.delayed(Duration(milliseconds: 500));
                          _adMobService.showRewardedAd();
                        },
                      );
                    case 4:
                      return ListTile(
                        leading: Icon(Icons.star),
                        title: Text('Uygulamayı puanla'),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return RatingDialog();
                            },
                          );
                        },
                      );

                    case 5:
                      return ListTile(
                        leading: Icon(Icons.assistant),
                        title: Text('Replik Öner'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReplikOner()),
                          );
                        },
                      );
                    case 6:
                      return ListTile(
                          leading: Icon(Icons.description),
                          title: Text('Gizlilik, Politikalar ve Telif Hakkı'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PrivacyPolicy()),
                            );
                          });

                    case 7:
                      return SwitchListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text('Küfür gösterilsin mi?'),
                        value: provider.kufur,
                        onChanged: (value) {
                          provider.kufur = value;
                          provider.saveSettings();
                          print(provider.kufur);
                        },
                      );

                    default:
                      return null;
                  }
                },
              ),
            ),
            Column(
              children: [AppVersionScreen()],
            )
          ],
        );
      }),
    );
  }
}
