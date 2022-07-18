import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'dart:core';
// import 'package:stickerbaba/models/Sticker.dart';

import 'dart:convert';

import 'package:stickerbaba/models/StickerPack.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String rawUrl =
      "https://raw.githubusercontent.com/moaj257/stickerbaba/master/assets";
  String url = "https://github.com/moaj257/stickerbaba/blob/master/assets";
  List<dynamic> stickerList = <StickerPack>[];
  bool isLoading = true;

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    var res = await http.get(Uri.parse('$rawUrl/contents.json'),
        headers: {"Accept": "application/json"});
    if (res.statusCode == 200) {
      return json
          .decode(res.body)['sticker_packs']
          .map((data) => StickerPack.fromJson(data))
          .toList();
      // setState(() {
      //   isLoading = false;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: getData(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              children: const [
                Text('Error',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 20),
                Text('Check your internet and try again',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    )),
              ],
            ),
          );
        } else if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          // Random random = new Random();
          int _colsPerRow = 3;
          return Column(
            children: [
              GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(10),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: _colsPerRow,
                  children: <Widget>[
                    ...snapshot.data.map((_v) => Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(15.0))),
                          child: Text(_v.name),
                        ))
                  ]),
            ],
          );
        }
        return const Text('to be done');
      },
    );
  }
}
