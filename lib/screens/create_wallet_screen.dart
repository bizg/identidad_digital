import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
// import 'package:progress_dialog/progress_dialog.dart';
import '../config/check_permissions.dart';
// import 'connect_mediator_screen.dart';
import 'package:AriesFlutterMobileAgent/AriesAgent.dart';
import 'package:flutter/foundation.dart';

import 'connection_screen.dart';

class CreateWalletScreen extends StatefulWidget {
  @override
  _CreateWalletScreenState createState() => _CreateWalletScreenState();
}

class _CreateWalletScreenState extends State<CreateWalletScreen> {
  // late ProgressDialog progressIndicator;
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
          {'id': walletNameController.text},
          {'key': walletKeyController.text},
          walletNameController.text,
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

  @override
  Widget build(BuildContext context) {
    // progressIndicator = new ProgressDialog(context);
    // progressIndicator.style(
    //   message: '   Pprocesando...',
    //   borderRadius: 10.0,
    //   backgroundColor: Colors.black54,
    //   progressWidget: CircularProgressIndicator(
    //     strokeWidth: 3,
    //   ),
    //   messageTextStyle: TextStyle(
    //     color: Colors.white,
    //     fontSize: 18,
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prueba agente Aries'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/LogoEPM.jpg',
              width: 300,
              height: 150,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              height: 50,
              child: TextField(
                controller: walletNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Nombre Billetera',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              height: 50,
              child: TextField(
                controller: walletKeyController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              height: 50,
              child: RaisedButton(
                color: Colors.green,
                onPressed: () async {
                  if (walletNameController.text != '' &&
                      walletKeyController.text != '') {
                    _createWallet();
                  }
                },
                child: const Text(
                  'Crear Billetera y Did',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
