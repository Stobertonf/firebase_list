import 'package:flutter/material.dart';
import 'package:firebase_list/shared/widgets/drawer/drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        drawer: CustonDrawer(),
      ),
    );
  }
}
