import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'dart:core';
// import 'package:stickerbaba/models/Sticker.dart';

import 'dart:convert';

import 'package:stickerbaba/models/StickerPack.dart';
// import 'package:stickerbaba/utils/Functions.dart';

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
          double _crossExtent = ((_screenWidth - 30) / _colsPerRow);
          double _crossExtentFeatured = ((_screenWidth - 30) / 2);
          // Functions _functions = Functions();
          // List _items = _functions.oneToMulti(snapshot.data, _colsPerRow);
          return Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 15.0,
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: _crossExtentFeatured,
                      mainAxisSpacing: 15.0,
                      crossAxisSpacing: 15.0,
                      childAspectRatio: 0.8,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: const BoxDecoration(
                              color: Color(0xFFddd9d8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Text(snapshot.data[index].name),
                        );
                      },
                      childCount: snapshot.data.take(2).length,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 15.0),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      children: [
                        Text('Sricker Packs',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600, fontSize: 20.0)),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, bottom: 15.0),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: _crossExtent,
                      mainAxisSpacing: 15.0,
                      crossAxisSpacing: 15.0,
                      childAspectRatio: 1,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: const BoxDecoration(
                              color: Color(0xFFddd9d8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Text(snapshot.data[index].name),
                        );
                      },
                      childCount: snapshot.data.length,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const Text('to be done');
      },
    );
  }
}
