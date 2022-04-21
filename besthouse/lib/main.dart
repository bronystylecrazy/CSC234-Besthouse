// packages
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// screens
import './screens/customer_profile.dart';
import './screens/favourite.dart';
import './screens/get_start.dart';
import './screens/guide.dart';
import './screens/home.dart';
import './screens/house_detailed.dart';
import './screens/offer_form.dart';
import './screens/search.dart';
import './screens/sign_in.dart';
import './screens/sign_up.dart';
import './screens/splash.dart';
import './screens/forget_password.dart';

// services
import './services/dio.dart';
import './services/provider.dart';

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
      title: 'Best House',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF24577A),
          secondary: const Color.fromARGB(255, 84, 156, 160),
        ),
        textTheme: TextTheme(
            headline3: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF24577A),
            ),
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
            bodyText1: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xff0E2B39)),
            bodyText2: GoogleFonts.poppins(
              fontSize: 14,
              color: const Color(0xFF022B3A),
              fontWeight: FontWeight.w600,
            ),
            subtitle1: GoogleFonts.poppins(fontSize: 14)),
      ),

      // home: const SplashScreen(),
      routes: {
        "/": (context) => const MyHomePage(),
        HouseDetailed.routeName: (context) => const HouseDetailed(),
        GetStart.routeName: (context) => const GetStart(),
        MyHomePage.routeName: (context) => const MyHomePage(),
        SignIn.routeName: (context) => const SignIn(),
        SignUp.routeName: (context) => const SignUp(),
        Guide.routeName: (context) => const Guide(),
        OfferForm.routeName: (context) => const OfferForm(),
        ForgetPassword.routeName: (context) => const ForgetPassword()
      },
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
        backgroundColor: Color(0xffFFFFFF),
        title: Row(
          children: [
            Image.asset("assets/logo.png", scale: 1.2),
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
        actions: <Widget>[
          IconButton(
            splashRadius: 20.0,
            icon: const Icon(Icons.menu_book),
            color: Theme.of(context).colorScheme.secondary,
            tooltip: 'Go to guide page',
            onPressed: () => Navigator.pushNamed(context, Guide.routeName,
                arguments: {"type": "customer"}),
          ),
        ],
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
