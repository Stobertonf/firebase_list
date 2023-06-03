import 'package:flutter/material.dart';
import 'package:firebase_list/shared/widgets/drawer/drawer.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final remoteConfig = FirebaseRemoteConfig.instance;
    return SafeArea(
      child: Scaffold(
        drawer: const CustonDrawer(),
        backgroundColor: Color(
          int.parse(
            "0xff${remoteConfig.getString("COR_FUNDO_TELA")}",
          ),
        ),
        appBar: AppBar(
          title: const Text("Home"),
        ),
      ),
    );
  }
}
