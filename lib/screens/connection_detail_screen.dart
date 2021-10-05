import 'package:identidad_digital/helpers/helpers.dart';
import 'package:identidad_digital/widgets/credential_dialog.dart';
import 'package:flutter/material.dart';

class ConnectionDetailScreen extends StatefulWidget {
  static const routeName = '/connectionDetail';
  @override
  _ConnectionDetailScreenState createState() => _ConnectionDetailScreenState();
}

class _ConnectionDetailScreenState extends State<ConnectionDetailScreen> {
  List<dynamic> credentialList = [];

  @override
  Widget build(BuildContext context) {
    final ConnectionDetailArguments data =
        ModalRoute.of(context)!.settings.arguments as ConnectionDetailArguments;
    final connection = data.connection!;
    return Scaffold(
      appBar: AppBar(
        title: Text('${connection['theirLabel']}'),
        automaticallyImplyLeading: true,
      ),
      body: credentialList.length > 0
          ? Container(
              color: Colors.grey[200],
              padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 0),
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(top: 5),
                itemCount: credentialList.length,
                itemBuilder: (BuildContext context, int index) {
                  var credential = credentialList[index];
                  var credName = 'sas';
                  if (credentialList.length == 0) {
                    return Center(
                      child: Text('Sin credenciales'),
                    );
                  }
                  return FlatButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CredentialDialog(
                          connection: connection,
                          credential: credential,
                        );
                      },
                    ),
                    height: 30,
                    child: Text(
                      '$credName',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.green,
                  );
                },
              ),
            )
          : Text('Sin credenciales'),
    );
  }
}
