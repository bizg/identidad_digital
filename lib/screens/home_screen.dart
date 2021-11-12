import 'package:flutter/material.dart';
import 'package:identidad_digital/screens/connection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 3:
        Navigator.pushNamed(context, ConnectionScreen.routeName);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Menu',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        body: const Center(
          child: Text('Aqui va el scaneo'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.inbox_rounded),
              label: 'Actions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article_outlined),
              label: 'Credentials',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.electrical_services),
              label: 'Connections',
            ),
          ],
          currentIndex: _selectedIndex,
          backgroundColor: Colors.white,
          elevation: 5,
          selectedItemColor: Colors.green,
          onTap: _onItemTapped,
        ),
        backgroundColor: Colors.white,
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                SizedBox(
                  height: 100,
                  child: DrawerHeader(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 1,
                      child: ListTile(
                        title: Row(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.topLeft,
                              child: const Expanded(
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topCenter,
                              padding: const EdgeInsets.only(
                                left: 10,
                              ),
                              child: const Expanded(
                                child: Text(
                                  'Configuración',
                                  style: TextStyle(
                                      fontSize: 21, color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    decoration: const BoxDecoration(color: Colors.green),
                  ),
                ),
                ListTile(
                  title: const Text('Nombre Wallet'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Permisos app'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Seguridad biometrica'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ));
  }
}
