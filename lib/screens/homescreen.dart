import 'package:flutter/material.dart';
import 'package:responsive_login_page/services/authservices.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        leading: InkWell(
            onTap: () async {
              await AuthServices().signout(context);
            },
            child: const Icon(Icons.logout)),
      ),
    );
  }
}
