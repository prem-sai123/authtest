import 'package:authtest/main.dart';
import 'package:authtest/sheets/LunchSheet.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flip_card/flip_card.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String? uname;
  @override
  void initState() {
    super.initState();
    getPrefDetails();
    getGoogleSheetAiData();
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
        builder: (context) => const MyApp(),
      ),
    );
  }

  final List<LunchSheet> _lunchSheetData = [];
  Future<void> getGoogleSheetAiData() async {
    var response = await http.get(Uri.parse(
        'https://script.google.com/macros/s/AKfycbxSHvImXTw1huV_Q54kfUw3-5YP8_-DgznJ_I24OhkPFIYnEMCZ_ItkoB1nswXDEhn-/exec'));
    var jsonRes = convert.jsonDecode(response.body);
    jsonRes.forEach((element) {
      LunchSheet lunchSheetModel = LunchSheet();
      lunchSheetModel.name = element['name'];
      lunchSheetModel.food = element['food'];
      lunchSheetModel.egg = element['egg'];
      _lunchSheetData.add(lunchSheetModel);
    });
    print(_lunchSheetData[0].name);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WelcomePage',
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Welcome'),
          toolbarHeight: 50,
          actions: [
            IconButton(
              onPressed: clearSharedPreferences,
              icon: const Icon(Icons.logout),
              color: Colors.white,
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: Card(
                  elevation: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blueAccent),
                ),
                    child:  FlipCard(
                      front:  const Center(child: Text('Welcome Note',textAlign: TextAlign.center,)),
                      back: Center(child: _lunchSheetData.isNotEmpty ? Text(_lunchSheetData[0].name!) : const Text('NO DATA')),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
