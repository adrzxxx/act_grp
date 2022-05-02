import 'package:flutter/material.dart';
import 'package:spincircle_bottom_bar/modals.dart';
import 'package:spincircle_bottom_bar/spincircle_bottom_bar.dart';
import 'package:odds_social_media/screens/firemap.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("RetroPortal Studio"),
          backgroundColor: Colors.deepOrangeAccent,
        ),
        //Adding SpinCircleBottomBarHolder to body of Scaffold
        body: SpinCircleBottomBarHolder(
          bottomNavigationBar: SCBottomBarDetails(
              circleColors: [Colors.white, Colors.orange, Colors.redAccent],
              iconTheme: const IconThemeData(color: Colors.black45),
              activeIconTheme: const IconThemeData(color: Colors.orange),
              backgroundColor: Colors.white,
              titleStyle: const TextStyle(color: Colors.black45, fontSize: 12),
              activeTitleStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
              actionButtonDetails: SCActionButtonDetails(
                  color: const Color.fromARGB(255, 120, 230, 230),
                  icon: const Icon(
                    Icons.add_alert_outlined,
                    color: Color.fromARGB(255, 232, 29, 29),
                  ),
                  elevation: 5),
              elevation: 2.0,
              items: [
                // Suggested count : 4
                SCBottomBarItem(
                    icon: Icons.verified_user, title: "User", onPressed: () {}),
                SCBottomBarItem(
                    icon: Icons.supervised_user_circle,
                    title: "Details",
                    onPressed: () {}),
                SCBottomBarItem(
                    icon: Icons.notifications,
                    title: "Notifications",
                    onPressed: () {}),
                SCBottomBarItem(
                    icon: Icons.details, title: "New Data", onPressed: () {}),
              ],
              circleItems: [
                //Suggested Count: 3
                SCItem(
                    icon: const Icon(Icons.add, color: Colors.black),
                    onPressed: () {}),
                SCItem(
                    icon: const Icon(Icons.print, color: Colors.black),
                    onPressed: () {}),
                SCItem(
                    icon: const Icon(Icons.map, color: Colors.black),
                    onPressed: () {}),
              ],
              bnbHeight: 150 // Suggested Height 80
              ),
          child: Container(
            color: Colors.orangeAccent.withAlpha(55),
            child: const Center(
              child: Text(" "),
            ),
          ),
        ),
      ),
    );
  }
}
