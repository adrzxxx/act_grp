import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:odds_social_media/screens/firemap.dart';
import 'package:odds_social_media/screens/home_screen.dart';
import 'package:odds_social_media/screens/login_screen.dart';
import 'package:odds_social_media/screens/signup_screen.dart';
import 'package:odds_social_media/utils/util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyASoiCL91zayfn-OH9y1cD-KMvl35Cz-Lc',
        appId: "1:999374116471:web:8ce30a0b96139b91779872",
        messagingSenderId: "999374116471",
        projectId: "odds-social-media",
        storageBucket: "odds-social-media.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'oddsapp',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileSearchColor,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const Mapscreen();
            } else if (snapshot.hasData) {
              return const Center(
                child: Text("error occured"),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
          return const LoginScreen();
        },
      ),
      // home: const ResponsiveLayout(
      //   mobileScreenLayout: MobileScreenLayout(),
      //   webScreenLayout: WebScreenLayout(),
    );
  }
}
