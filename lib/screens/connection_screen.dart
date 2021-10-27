// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:identidad_digital/config/check_permissions.dart';
import 'package:identidad_digital/helpers/helpers.dart';
import 'package:identidad_digital/screens/connection_detail_screen.dart';
import 'package:identidad_digital/screens/qrcode_screen.dart';
import 'package:identidad_digital/widgets/custom_dialog_box.dart';
import 'package:identidad_digital/utils/dialogs.dart' as dialog;
import 'package:qr_mobile_vision/qr_camera.dart';
// import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:AriesFlutterMobileAgent/AriesAgent.dart';

class ConnectionScreen extends StatefulWidget {
  static const routeName = '/connections';

  const ConnectionScreen({Key? key}) : super(key: key);
  @override
  _ConnectionScreenState createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen>
    with SingleTickerProviderStateMixin {
  late String qr = '';
  bool camState = false;
  var permission = false;
  late TabController tabController;
  // late ProgressDialog progressIndicator;
  String? label = "";
  String? endPoint = "";
  List<dynamic> connectionList = [];
  List<dynamic>? credentialList = [];
  List<dynamic> messageList = [];
  String title = "Pagina principal";

  Future eventListener() async {
    emitterAriesSdk.on("SDKEvent", null, (ev, context) async {
      await getConnections();
      await getAllCredentials();
      await getAllActionMessages();
    });
  }

  void connectSocket() async {
    try {
      var sdkDB = await AriesFlutterMobileAgent.getWalletData();
      if (sdkDB != null) {
        AriesFlutterMobileAgent.socketInit();
      }
    } catch (exception) {
      debugPrint('Error general. $exception');
      rethrow;
    }
  }

  addNewConnection() async {
    var result = QrCamera(qrCodeCallback:(value) => value);
    debugPrint(result.hashCode.toString());
    // var result = await BarcodeScanner.scan();
    // Object val = decodeInvitationFromUrl(result.toString());
    // Map<String, dynamic> values = jsonDecode(val as String);

    // if (values['serviceEndpoint'] != null) {
    //   setState(() {
    //     label = values['label'];
    //     endPoint = values['serviceEndpoint'];
    //   });
    //   showAlertDialog(result.toString());
    // }
  }

  validatePermission() async {
    permission = await CheckPermissions.requestCameraPermission();
  }

  showAlertDialog(invitation) {
    Widget confirm = FlatButton(
      child: const Text("ACEPTAR"),
      onPressed: () {
        Navigator.pop(context);
        // progressIndicator.show();
        acceptInvitation(invitation);
      },
      color: Colors.green,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
      minWidth: MediaQuery.of(context).size.width - 30,
    );

    Widget cancel = FlatButton(
      child: const Text("CANCELAR"),
      onPressed: Navigator.of(context, rootNavigator: true).pop,
      textColor: Colors.green,
      color: Colors.white,
      minWidth: MediaQuery.of(context).size.width - 30,
    );

    AlertDialog alert = AlertDialog(
      title: RichText(
        text: TextSpan(
          children: <TextSpan>[
            const TextSpan(
              text:
                  'Desea configurar una conexion segura ',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Column(
          children: [
        confirm,
        cancel,
          ],
        )
      ],
    );

    showDialog(
      context: context,
      builder: (context) {
        return alert;
      },
    );
  }

  Future acceptInvitation(invitation) async {
    try {
      await AriesFlutterMobileAgent.acceptInvitation(
        {},
        invitation,
      );
      // progressIndicator.hide();
      await AriesFlutterMobileAgent.socketInit();
      setState(() {
        getConnections();
      });
    } catch (exception) {
      rethrow;
    }
  }

  Future getConnections() async {
    List<dynamic> connections =
        await AriesFlutterMobileAgent.getAllConnections();
    setState(() {
      connectionList = connections;
    });
  }

  Future getAllCredentials() async {
    try {
      // progressIndicator.show();
      List<dynamic>? credentials =
          await (AriesFlutterMobileAgent.listAllCredentials(filter: {}) as FutureOr<List<dynamic>?>);
      // progressIndicator.hide();
      setState(() {
        credentialList = credentials;
      });
    } catch (exception) {
      debugPrint("Error listando las credenciales $exception");
      rethrow;
    }
  }

  Future getAllActionMessages() async {
    try {
      List<dynamic> messages =
          await AriesFlutterMobileAgent.getAllActionMessages();
      setState(() {
        messageList = messages;
      });
    } catch (exception) {
      rethrow;
    }
  }

  Future createInvitation() async {
    var qrcode = await AriesFlutterMobileAgent.createInvitation({});
    Navigator.pushNamed(
      context,
      QRcodeScreen.routeName,
      arguments: ScreenArguments(qrcode),
    );
  }

  void navigateToConnectionDetail(connection) {
    Navigator.pushNamed(
      context,
      ConnectionDetailScreen.routeName,
      arguments: ConnectionDetailArguments(connection),
    );
  }

  @override
  void initState() {
    super.initState();
    eventListener();
    getConnections();
    connectSocket();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // progressIndicator = new ProgressDialog(context);
    // progressIndicator.style(
    //   message: '   Procesando ...',
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: "Conexiones"),
              Tab(text: "Credenciales"),
              Tab(text: "Acciones"),
            ],
          ),
          title: const Text("Página principal"),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: camState && permission
                      ? Center(
                          child: SizedBox(
                            width: 300.0,
                            height: 600.0,
                            child: QrCamera(
                              onError: (context, error) => Text(
                                error.toString(),
                                style: const TextStyle(color: Colors.red),
                              ),
                              qrCodeCallback: (code) {
                                setState(() {
                                  qr = code!;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: Colors.orange,
                                      width: 10.0,
                                      style: BorderStyle.solid),
                                ),
                              ),
                            ),
                          ),
                        )
                      : const Center(child: Text("Camera inactive"))),
              Text("QRCODE: $qr"),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Text(
              "press me",
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              validatePermission();
              setState(() {
                camState = !camState;
              });
            }),
      )
    );
  }
}


