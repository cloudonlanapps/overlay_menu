import 'package:flutter/material.dart';
import 'package:overlay_menu/overlay_menu.dart';

import 'long_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Overlay Menu Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ContentWithOverlayMenu(),
    );
  }
}

class ContentWithOverlayMenu extends StatelessWidget {
  const ContentWithOverlayMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: OverlayMenu(
          topMenuItems: [
            MenuItem("Begin", Icons.arrow_upward, onTap: () {}),
            MenuItem("End", Icons.arrow_downward, onTap: () {}),
          ],
          topMenuItemSpecialLeft: MenuItem("Back", Icons.arrow_upward,
              onTap: () {}, showLabel: false),
          bottomMenuItems: [
            MenuItem("Home", Icons.home, onTap: () {}),
            MenuItem("Settings", Icons.settings, onTap: () {}),
            MenuItem("Style", Icons.style, onTap: () {})
          ],
          hideMenuItem: MenuItem("", Icons.close, showLabel: false),
          timeout: const Duration(seconds: 3),
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  longText,
                  style: TextStyle(fontSize: 16.0),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
