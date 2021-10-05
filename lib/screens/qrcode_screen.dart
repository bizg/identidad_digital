import 'package:identidad_digital/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRcodeScreen extends StatefulWidget {
  static const routeName = '/qrcode';
  @override
  _QRcodeScreenState createState() => _QRcodeScreenState();
}

class _QRcodeScreenState extends State<QRcodeScreen> {
  @override
  Widget build(BuildContext context) {
    final ScreenArguments data = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Qr'),
      ),
      body: Center(
        child: Container(
          child: QrImage(
            data: data.url!,
            version: QrVersions.auto,
            size: 300,
          ),
        ),
      ),
    );
  }
}
