import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meme_app/home_page.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Splashscreen(),
    );
  }
}

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: MyHomePage(),
      title: Text(
        "Memespam",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 40,
          fontFamily: "Roboto",
        ),
      ),
//      image: ,
      backgroundColor: Colors.deepPurple,
//      photoSize: ,
      loadingText: Text(
        "Loading...",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      loaderColor: Colors.white,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//        print('connected');
      }
    } on SocketException catch (_) {
//      print('not connected');
      showNoInternet(context);
    }
  }

  void showNoInternet(context) {
    AwesomeDialog(
      context: context,
      headerAnimationLoop: true,
      dialogType: DialogType.WARNING,
      animType: AnimType.BOTTOMSLIDE,
      btnOkOnPress: () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyApp(),
        ),
      ),
      btnOkColor: Colors.yellow[800],
      btnOkText: 'Reload',
      title: 'No Internet',
      desc: 'Please check your internet connection and try again later',
      body: Center(
        child: Text(
          'Please check your internet connection and try again',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
    ).show();
  }

  @override
  void initState() {
    super.initState();
    checkInternet();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(),
    );
  }
}
