import 'package:identidad_digital/screens/connection_detail_screen.dart';
import 'package:identidad_digital/screens/connection_screen.dart';
import 'package:identidad_digital/screens/create_wallet_screen.dart';
import 'package:identidad_digital/screens/qrcode_screen.dart';
import 'package:flutter/material.dart';
import 'package:AriesFlutterMobileAgent/AriesAgent.dart';

import 'screens/connect_mediator_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AriesFlutterMobileAgent.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loggedIn = false;

  void isValidUser() async {
    var userData = await AriesFlutterMobileAgent.getWalletData();
    if (userData != null) {
      setState(() {
        loggedIn = true;
      });
    }
  }

  void connectSocket() async {
    try {
      var sdkDB = await AriesFlutterMobileAgent.getWalletData();
      if (sdkDB != null) {
        AriesFlutterMobileAgent.socketInit();
      }
    } catch (exception) {
      print('Oops! Something went wrong. Please try again later. $exception');
      throw exception;
    }
  }

  @override
  void initState() {
    super.initState();
    connectSocket();
    isValidUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Agent',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      // home: loggedIn ? const ConnectionScreen() : CreateWalletScreen(),
      home: loggedIn ? CreateWalletScreen() : CreateWalletScreen(),
      routes: {
        ConnectMediatorScreen.routeName: (ctx) => const ConnectMediatorScreen(),
        ConnectionScreen.routeName: (ctx) => const ConnectionScreen(),
        ConnectionDetailScreen.routeName: (ctx) => ConnectionDetailScreen(),
        QRcodeScreen.routeName: (ctx) => QRcodeScreen(),
      },
    );
  }
}
