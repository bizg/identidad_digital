import 'package:flutter/services.dart';
import 'package:identidad_digital/config/check_permissions.dart';
import 'package:identidad_digital/screens/connection_detail_screen.dart';
import 'package:identidad_digital/screens/connection_screen.dart';
// import 'package:identidad_digital/screens/create_wallet_screen.dart';
import 'package:identidad_digital/screens/home_screen.dart';
// import 'package:identidad_digital/screens/qrcode_screen.dart';
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

  TextEditingController walletNameController = TextEditingController();
  TextEditingController walletKeyController = TextEditingController();
  // ignore: unused_field
  String? _did = "";
  Future<void> _createWallet() async {
    List<dynamic> createWalletData;
    List<String> arrayData;
    try {
      debugPrint('DEBUG TEST WALLET -------------------------------');
      var permission = await CheckPermissions.requestStoragePermission();
      if (permission) {
        // progressIndicator.show();
        createWalletData = await AriesFlutterMobileAgent.createWallet(
          {'id': 'wallet_id'},
          {'key': 'wallet_key'},
          'wallet_id',
        );
        arrayData = List<String>.from(createWalletData);
        debugPrint('DEBUG TEST WALLET: $arrayData');
        var didTolog = arrayData[0];
        debugPrint('DEBUG TEST WALLET: $didTolog');
        setState(() {
          _did = arrayData[0];
          //_did = "CxCYYt9dq5gAknRvSkujk7";
          // progressIndicator.hide();
        });
        Navigator.pushNamed(context, ConnectionScreen.routeName);
      } else {
        // progressIndicator.hide();
        setState(() {
          _did = "No se tienen permisos de almacenado";
        });
      }
    } on PlatformException catch (err) {
      // progressIndicator.hide();
      if (err.code == '203') {
        setState(() {
          _did = "La billetera ya existe";
        });
      }
    }
  }

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
      debugPrint('Oops! Something went wrong. Please try again later. $exception');
      throw exception;
    }
  }

  @override
  void initState() {
    super.initState();
    _createWallet();
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
      home: const HomeScreen(),
      routes: {
        ConnectMediatorScreen.routeName: (ctx) => const ConnectMediatorScreen(),
        ConnectionScreen.routeName: (ctx) => const ConnectionScreen(),
        ConnectionDetailScreen.routeName: (ctx) => ConnectionDetailScreen(),
        // QRcodeScreen.routeName: (ctx) => QRcodeScreen(),
      },
    );
  }
}
