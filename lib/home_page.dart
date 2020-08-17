import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meme_app/models/images_helper.dart';
import 'package:meme_app/models/meme_service.dart';
import 'package:meme_app/pages/edit_meme_page.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:firebase_admob/firebase_admob.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: <String>[],
    nonPersonalizedAds: true,
    keywords: <String>['Flutter','Java'],
  );

  InterstitialAd _interstitialAd;

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        adUnitId: 'ca-app-pub-5876464688073365/9695568253',
//        adUnitId: InterstitialAd.testAdUnitId,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("InterstitialAd : $event");
        });
  }

  MemeService memeService = MemeService();

  void getImage() async {
    File file = await FilePicker.getFile();
    Navigator.push(context, MaterialPageRoute(builder: (context) => EditMemePage(
      memeUrl: "",
      memeName: "Image from gallery",
      memeImage: file,
    )));
  }

  void sendEmail() async {
    final Email email = Email(
      recipients: ['mohitdevelopersingh11082002@gmail.com'],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(
//       appId: FirebaseAdMob.testAppId,
       appId: 'ca-app-pub-5876464688073365~7260976605',
    );
  }

  @override
  void dispose() {
//     _bannerAd.dispose();
    _interstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text(
                "Memespam",
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: "Roboto",
                ),
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            ListTile(
              onTap: () {
                createInterstitialAd()..load()..show();
                getImage();
              },
              leading: Icon(FontAwesomeIcons.image),
              title: Text(
                "Pick from gallery",
              ),
            ),
            ListTile(
              onTap: () {
                sendEmail();
              },
              leading: Icon(FontAwesomeIcons.userAlt),
              title: Text(
                "Contact us",
              ),
              subtitle: Text(
                "Questions?Need help?",
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        shadowColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Memespam",
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: memeService.getData(),
          builder: (_, AsyncSnapshot<List<ImagesHelper>> snapshot) {
            if(snapshot.hasData) {
              return StaggeredGridView.countBuilder(
                crossAxisCount: 4,
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return SingleChildScrollView(
                    child: GestureDetector(
                      onTap: () {
                        createInterstitialAd()..load()..show();
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return EditMemePage(
                            memeUrl: snapshot.data[index].url,
                            memeName: snapshot.data[index].name,
                          );
                        }));
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 1,
                            color: Colors.white54,
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(snapshot.data[index].url),
                                ),
                              ),
                            ),
                            Text(
                                snapshot.data[index].name,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (int index) => new StaggeredTile.count(2, 2),
                mainAxisSpacing: 3.0,
                crossAxisSpacing: 3.0,
              );
            } else {
              return Center(
                child: SpinKitThreeBounce(
                  color: Colors.white,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
