import 'dart:convert';

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
    {'name': 'Explore', 'component': const Home()},
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
              icon: EvaIcons.homeOutline, text: _pages[0]['name'] as String),
          GButton(
              icon: EvaIcons.trendingUpOutline,
              text: _pages[1]['name'] as String),
          GButton(
              icon: EvaIcons.heartOutline, text: _pages[2]['name'] as String),
          GButton(
              icon: EvaIcons.settings2Outline,
              text: _pages[3]['name'] as String),
        ],
        selectedIndex: _selectedPage,
        onTabChange: (int index) {
          setState(() {
            _selectedPage = index;
          });
          // print(json.decode(_pages.elementAt(_selectedPage)));
        });
    return Scaffold(
        appBar: AppBar(
          title: Text(
            _pages[_selectedPage]['name'] as String,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(EvaIcons.searchOutline))
          ],
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
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
