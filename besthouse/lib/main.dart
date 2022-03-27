import 'package:besthouse/screens/customer_profile.dart';
import 'package:besthouse/screens/favourite.dart';
import 'package:besthouse/screens/get_start.dart';
import 'package:besthouse/screens/guide.dart';
import 'package:besthouse/screens/home.dart';
import 'package:besthouse/screens/house_detailed.dart';
import 'package:besthouse/screens/post_form.dart';
import 'package:besthouse/screens/search.dart';
import 'package:besthouse/screens/sign_in.dart';
import 'package:besthouse/screens/sign_up.dart';
import 'package:besthouse/services/dio.dart';
import 'package:besthouse/services/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
      ],
      child: const MyApp(),
    ),
  );
  DioInstance.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        textTheme: TextTheme(
            headline2: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF24577A)),
            headline1: GoogleFonts.poppins(
                fontSize: 38,
                fontWeight: FontWeight.w600,
                color: Color(0xFF022B3A))),
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: SignUp(),
      routes: {
        HouseDetailed.routeName: (context) => HouseDetailed(),
        GetStart.routeName: (context) => GetStart(),
        SignIn.routeName: (context) => SignIn(),
        SignUp.routeName: (context) => SignUp(),
        Guide.routeName: (context) => Guide(),
        PostForm.routeName: (context) => PostForm(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> screen = <Widget>[
    const Home(),
    const Search(),
    const Favourite(),
    const CustomerProfile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: screen.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.blue,
          ),
        ],
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        // showSelectedLabels: false,
      ),
    );
  }
}
