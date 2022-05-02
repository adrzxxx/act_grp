import 'package:flutter/material.dart';
import 'package:odds_social_media/screens/firemap.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/link.dart';

class MyAppp extends StatelessWidget {
  const MyAppp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Page1(),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('About Us'),
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: ((context) => const Mapscreen()))),
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
            label: const Text('home', style: TextStyle(color: Colors.black)),
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(32),
        child: ElevatedButton(
          child: const Text('about us'),
          onPressed: () async {
            final url =
                'https://fwesh.yonle.repl.co/'; //'https://sites.google.com/view/helpcentrevit/home'

            if (await canLaunch(url)) {
              await launch(
                url,
                forceWebView: true,
                enableJavaScript: true,
              );
            }
          },
        ),
      ),
    );
  }
}
