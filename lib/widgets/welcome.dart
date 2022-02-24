import 'package:authtest/homepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String? uname;
  @override
  void initState() {
    super.initState();
    getPrefDetails();
  }

  void getPrefDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      uname = pref.get('uname') as String?;
    });
  }

  clearSharedPreferences() async {
    SharedPreferences sPref = await SharedPreferences.getInstance();
    await sPref.clear();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WelcomePage',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome'),
          toolbarHeight: 50,
          actions: [
            IconButton(
              onPressed: clearSharedPreferences,
              icon: const Icon(Icons.logout),
              color: Colors.indigo,
            )
          ],
        ),
        body: Center(
          child: Column(
            children: [
              const Text('Welcome'),
              Text(uname ?? uname!),
            ],
          ),
        ),
      ),
    );
  }
}
