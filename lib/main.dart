import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import './screens/Home.dart';
import './screens/Trending.dart';
import './screens/Favourites.dart';
import './screens/Settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: const ColorScheme.dark(),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedPage = 0;
  final _pages = [
    Home(),
    Trending(),
    Favourites(),
    Settings()
  ];

  @override
  Widget build(BuildContext context) {
    GNav bottomNavigation = GNav(
      gap: 8,
      backgroundColor: Colors.white,
      activeColor: Colors.black,
      color: Colors.black,
      tabBackgroundColor: Colors.black12,
      padding: const EdgeInsets.all(12.0),
      tabs: const [
        GButton(icon: EvaIcons.homeOutline, text: 'Home'),
        GButton(icon: EvaIcons.trendingUpOutline, text: 'Trending'),
        GButton(icon: EvaIcons.heartOutline, text: 'Likes'),
        GButton(icon: EvaIcons.settings2Outline, text: 'Settings'),
      ],
      selectedIndex: _selectedPage,
      onTabChange: (int index) {
        setState(() {
          _selectedPage = index;
        });
      }
    ); 
    return Scaffold(
      body: _pages.elementAt(_selectedPage),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
          child: bottomNavigation,
        ),
      )
    );
  }
}
