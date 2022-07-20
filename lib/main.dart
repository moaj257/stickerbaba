import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
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
      title: 'Sticker Baba',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: const ColorScheme.light(),
      ),
      debugShowCheckedModeBanner: false,
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
    {'name': 'Featured', 'component': const Home()},
    {'name': 'Trending', 'component': Trending()},
    {'name': 'Favourites', 'component': Favourites()},
    {'name': 'Settings', 'component': Settings()}
  ];

  @override
  Widget build(BuildContext context) {
    GNav bottomNavigation = GNav(
        gap: 8,
        backgroundColor: Colors.black,
        activeColor: Colors.white,
        color: Colors.white,
        tabBackgroundColor: Colors.white24,
        padding: const EdgeInsets.all(12.0),
        tabs: [
          GButton(
            icon: EvaIcons.homeOutline,
            text: _pages[0]['name'] as String,
            textStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, color: Colors.white),
          ),
          GButton(
            icon: EvaIcons.trendingUpOutline,
            text: _pages[1]['name'] as String,
            textStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, color: Colors.white),
          ),
          GButton(
            icon: EvaIcons.heartOutline,
            text: _pages[2]['name'] as String,
            textStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, color: Colors.white),
          ),
          GButton(
            icon: EvaIcons.settings2Outline,
            text: _pages[3]['name'] as String,
            textStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ],
        selectedIndex: _selectedPage,
        onTabChange: (int index) {
          setState(() {
            _selectedPage = index;
          });
          // print(json.decode(_pages.elementAt(_selectedPage)));
        });
    return Scaffold(
        appBar: MyAppBar(title: _pages[_selectedPage]['name'] as String),
        body: _pages[_selectedPage]['component'] as Widget,
        bottomNavigationBar: Container(
          color: Colors.black,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: bottomNavigation,
          ),
        ));
  }
}

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final double appBarHeight = 70.0;
  final String title;

  const MyAppBar({Key? key, required this.title}) : super(key: key);

  @override
  get preferredSize => Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _size = _screenWidth / 2;
    return Container(
        clipBehavior: Clip.hardEdge,
        width: _screenWidth,
        padding: const EdgeInsets.only(left: 20.0),
        decoration: const BoxDecoration(
            color: Color(0xFF605174),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0))),
        child: Stack(children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 24.0,
                      color: Colors.white),
                )
              ]),
          Positioned(
              right: -(_size / 3),
              bottom: -(_size / 5),
              child: Container(
                  width: _size,
                  height: _size,
                  decoration: const BoxDecoration(
                      color: Color(0xFF665878), shape: BoxShape.circle)))
        ]));
  }
}
