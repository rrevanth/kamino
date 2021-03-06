// Import flutter libraries
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:kamino/ui/uielements.dart';

// Import custom libraries / utils
import 'animation/transition.dart';
// Import pages
import 'pages/home.dart';
// Import views
import 'view/search.dart';
import 'view/settings.dart';

var themeData = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    accentColor: secondaryColor,
    splashColor: backgroundColor,
    highlightColor: highlightColor,
    backgroundColor: backgroundColor);

const primaryColor = const Color(0xFF8147FF);
const secondaryColor = const Color(0xFF303A47);
const backgroundColor = const Color(0xFF26282C);
const highlightColor = const Color(0x968147FF);
const appName = "ApolloTV";

void main() {
  // MD2: Remove status bar translucency.
  changeStatusColor(Color color) async {
    try {
      await FlutterStatusbarcolor.setStatusBarColor(color);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  changeStatusColor(const Color(0x00000000));

  runApp(
    new MaterialApp(
        title: appName,
        home: KaminoApp(),
        theme: themeData,

        // Hide annoying debug banner
        debugShowCheckedModeBanner: false),
  );
}

class KaminoApp extends StatefulWidget {
  @override
  HomeAppState createState() => new HomeAppState();
}

class HomeAppState extends State<KaminoApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: AppBar(
          title: TitleText(appName),
          // MD2: make the color the same as the background.
          backgroundColor: backgroundColor,
          // Remove box-shadow
          elevation: 0.00,

          // Center title
          centerTitle: true,
        ),
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                child: null,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/header.png'),
                        fit: BoxFit.fitHeight,
                        alignment: Alignment.bottomCenter),
                    color: const Color(0xFF000000))),
            ListTile(
                leading: const Icon(Icons.library_books), title: Text("News")),
            Divider(),
            ListTile(
                leading: const Icon(Icons.gavel), title: Text('Disclaimer')),
            ListTile(
                leading: const Icon(Icons.favorite), title: Text('Donate')),
            ListTile(
                leading: const Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  Navigator.of(context).pop();

                  Navigator.push(context,
                      SlideLeftRoute(builder: (context) => SettingsView()));
                })
          ],
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton.extended(
            label: const Text("Search",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontFamily: 'GlacialIndifference',
                    letterSpacing: 0.2,
                    fontSize: 18.0)),
            icon: Icon(const IconData(0xe90a, fontFamily: 'apollotv-icons')),
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 12.0,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchView())
              );
            }),
        bottomNavigationBar: BottomAppBar(
          color: const Color(0xFF252525),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    // TODO: button code
                  },
                  icon: Icon(
                      const IconData(0xe900, fontFamily: 'apollotv-icons')),
                  color: Theme.of(context).primaryColor),
              IconButton(
                  onPressed: null,
                  icon: Icon(Icons.movie),
                  color: Colors.grey.shade400,
                  tooltip: "Movies"),
              Padding(
                padding: const EdgeInsets.only(left: 125.0),
                child: IconButton(
                  onPressed: null,
                  icon: Icon(Icons.live_tv),
                  color: Colors.grey.shade400,
                ),
              ),
              IconButton(
                onPressed: null,
                icon: Icon(Icons.favorite_border),
                color: Colors.grey.shade400,
              ),
            ],
          ),
          elevation: 18.0,
        ),

        // Body content
        body: HomePage().build(context));
  }
}
