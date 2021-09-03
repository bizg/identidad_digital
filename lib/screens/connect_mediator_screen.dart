import 'dart:convert';

import 'package:AriesFlutterMobileAgent/AriesAgent.dart';
import 'package:AriesFlutterMobileAgent_example/helpers/helpers.dart';
import 'package:AriesFlutterMobileAgent_example/screens/connection_screen.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter/foundation.dart';

class ConnectMediatorScreen extends StatefulWidget {
  static const routeName = '/connectMediator';

  @override
  _ConnectMediatorScreenState createState() => _ConnectMediatorScreenState();
}

class _ConnectMediatorScreenState extends State<ConnectMediatorScreen> {
  ProgressDialog progressIndicator;
  String _status = "";

  Future<void> connectWithMediator() async {
    try {
      progressIndicator.show();
      var user = await AriesFlutterMobileAgent.getWalletData();
      var stringUser = user.toString();
      debugPrint('DEBUG TEST USUARIO: $stringUser');
      debugPrint('DEBUG TEST URL MEDIADOR: $MediatorAgentUrl');
      var mediator = await AriesFlutterMobileAgent.connectWithMediator(
        "$MediatorAgentUrl/discover",
        jsonEncode({
          'myDid': user.publicDid,
          'verkey': user.verkey,
          'label': user.label,
        }),
        PoolConfig,
      );
      if (mediator) {
        this.setState(() {
          _status = "Connected";
        });
      }
      progressIndicator.hide();

      Navigator.pushNamed(context, ConnectionScreen.routeName);
    } catch (error) {
      progressIndicator.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    progressIndicator = new ProgressDialog(context);
    progressIndicator.style(
      message: '   Procesando ...',
      borderRadius: 10.0,
      backgroundColor: Colors.black54,
      progressWidget: CircularProgressIndicator(
        strokeWidth: 3,
      ),
      messageTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conectar con un mediador'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              height: 40,
              child: RaisedButton(
                color: Colors.green,
                onPressed: () async {
                  await connectWithMediator();
                },
                child: Text(
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
