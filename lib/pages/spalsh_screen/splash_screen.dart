import 'dart:js';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:firebase_list/pages/home/home_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

carregarHome() async {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  analytics.logEvent(name: "SplashScreenOepn");
  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString('user_id');
  if (userId == null) {
    var uuid = const Uuid();
    userId = uuid.v4();
    await prefs.setString('user_id', userId);
  }
  Future.delayed(
    const Duration(seconds: 2),
    () {
      Navigator.pushReplacement(
        context as BuildContext,
        MaterialPageRoute(
          builder: (_) => const HomePage(),
        ),
      );
    },
  );
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
