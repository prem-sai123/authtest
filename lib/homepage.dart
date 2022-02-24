import 'package:authtest/widgets/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:authtest/cubit/signincubit_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final userNameController = TextEditingController();
  final passWdController = TextEditingController();
  bool _showPasswd = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? val = await preferences.getString('uname');
    if (val != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext coxContext) {
    return Scaffold(
      body: Column(
        children: [
          Card(
            elevation: 5,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.only(right: 5, left: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blueAccent),
                  gradient:  LinearGradient(
                      colors: [Colors.blue.shade50,Colors.blue.shade50, Colors.blue.shade100, Colors.blue.shade50,Colors.blue.shade50],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter)),
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: userNameController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      labelText: 'User Name',
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextField(
                    controller: passWdController,
                    obscureText: !_showPasswd,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      border: const OutlineInputBorder(),
                      labelText: 'Password',
                      suffixIcon: GestureDetector(
                        child: Icon(
                          _showPasswd ? Icons.visibility : Icons.visibility_off,
                        ),
                        onTap: () {
                          setState(() {
                            _showPasswd = !_showPasswd;
                          });
                        },
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final result =
                          await BlocProvider.of<SignincubitCubit>(context)
                              .givenDetais(
                                  userNameController.text, passWdController.text);
                      if (result) {
                        final SharedPreferences mySharedPref =
                            await SharedPreferences.getInstance();
                        await mySharedPref.setString(
                            'uname', userNameController.text);
                        await mySharedPref.setString('pswd', passWdController.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WelcomePage(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            width: 200,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            duration: Duration(seconds: 5),
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              'Invalid Credentials',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text('LOGIN'),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: Card(
              elevation: 5,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  scrollDirection:  Axis.horizontal,
                  child: Row(
                    children: [
                      Image.asset('assets/images/easycloud.png',width: MediaQuery.of(context).size.width),
                    ],
                  ),
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}
