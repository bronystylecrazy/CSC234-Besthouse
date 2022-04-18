import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:besthouse/screens/customer_profile.dart';
import 'package:besthouse/screens/favourite.dart';
import 'package:besthouse/screens/get_start.dart';
import 'package:besthouse/screens/guide.dart';
import 'package:besthouse/screens/home.dart';
import 'package:besthouse/screens/house_detailed.dart';
import 'package:besthouse/screens/offer_form.dart';
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
        primaryColor: Color(0xff24577A),
        textTheme: TextTheme(
            headline2: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF24577A),
            ),
            headline1: GoogleFonts.poppins(
              fontSize: 38,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF022B3A),
            ),
            bodyText1:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
            bodyText2: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFF022B3A),
                fontWeight: FontWeight.bold),
            subtitle1: GoogleFonts.poppins(fontSize: 14)),
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),

      // home: const SplashScreen(),
      routes: {
        "/": (context) => MyHomePage(),
        HouseDetailed.routeName: (context) => const HouseDetailed(),
        GetStart.routeName: (context) => const GetStart(),
        MyHomePage.routeName: (context) => const MyHomePage(),
        SignIn.routeName: (context) => const SignIn(),
        SignUp.routeName: (context) => const SignUp(),
        Guide.routeName: (context) => const Guide(),
        OfferForm.routeName: (context) => const OfferForm(),
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3000,
      splash: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Positioned(
              child: Image.asset("assets/logo.png", scale: 0.8),
              top: 50,
              left: 18,
            ),
            Text('BestHouse',
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF24577A))),
            Text('Welcome to BestHouse',
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF24577A))),
          ],
        ),
      ),
      nextScreen: GetStart(),
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);
  static const String routeName = "/homepage";

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
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset("assets/logo.png", scale: 1),
            const SizedBox(
              width: 8,
            ),
            Text(
              "Best house",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: screen.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black,
            spreadRadius: -4,
            blurRadius: 5,
          )
        ]),
        child: BottomNavigationBar(
          selectedItemColor: const Color(0xff24577A),
          unselectedItemColor: const Color(0xff7E95A6),
          selectedLabelStyle: GoogleFonts.poppins(),
          unselectedLabelStyle: GoogleFonts.poppins(),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
              ),
              label: 'Favourite',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'Profile',
            ),
          ],
          showUnselectedLabels: true,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          // showSelectedLabels: false,
        ),
      ),
    );
  }
}
