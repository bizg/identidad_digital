import 'dart:convert';

import 'package:AriesFlutterMobileAgent/AriesAgent.dart';
import 'package:identidad_digital/helpers/helpers.dart';
import 'package:identidad_digital/screens/connection_screen.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter/foundation.dart';

class ConnectMediatorScreen extends StatefulWidget {
  static const routeName = '/connectMediator';

  const ConnectMediatorScreen({Key? key}) : super(key: key);

  @override
  _ConnectMediatorScreenState createState() => _ConnectMediatorScreenState();
}

class _ConnectMediatorScreenState extends State<ConnectMediatorScreen> {
  // late ProgressDialog progressIndicator;
  String _status = "";

  Future<void> connectWithMediator() async {
    try {
      // progressIndicator.show();
      var user = await (AriesFlutterMobileAgent.getWalletData());
      var stringUser = user.toString();
      debugPrint('DEBUG TEST USUARIO: $stringUser');
      debugPrint('DEBUG TEST URL MEDIADOR: $MediatorAgentUrl');
      var mediator = await AriesFlutterMobileAgent.connectWithMediator(
        "$MediatorAgentUrl/discover",
        jsonEncode({
          'myDid': user!.publicDid,
          'verkey': user.verkey,
          'label': user.label,
        }),
        PoolConfig,
      );
      debugPrint('DEBUG TEST MEDIADOR: $mediator');
      if (mediator) {
        setState(() {
          _status = "Connected";
        });
      }
      // progressIndicator.hide();

      Navigator.pushNamed(context, ConnectionScreen.routeName);
    } catch (error) {
      // progressIndicator.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    // progressIndicator = ProgressDialog(context);
    // progressIndicator.style(
    //   message: '   Procesando ...',
    //   borderRadius: 10.0,
    //   backgroundColor: Colors.black54,
    //   progressWidget: const CircularProgressIndicator(
    //     strokeWidth: 3,
    //   ),
    //   messageTextStyle: const TextStyle(
    //     color: Colors.white,
    //     fontSize: 18,
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conectar con un mediador'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              height: 40,
              child: RaisedButton(
                color: Colors.green,
                onPressed: () async {
                  await connectWithMediator();
                },
                child: const Text(
                  'Conectar con un mediador',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          Text(
            'status : $_status',
            style: TextStyle(
              color: _status == "Connected" ? Colors.green : null,
            ),
          ),
        ],
      ),
    );
  }
}
