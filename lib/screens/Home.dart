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
    int _count = 6;
    double _screenWidth = MediaQuery.of(context).size.width - 2.0;
    double _stickerSize = ((_screenWidth - (10 * _count)) / _count);
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
          Random random = new Random();
          int _featuredIndex = random.nextInt(snapshot.data.length);
          // print(snapshot.hasData ? snapshot.data.length : 0);
          return Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Card(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 25.0),
                    width: _screenWidth - 10,
                    decoration: BoxDecoration(
                        color: Colors.deepPurple.shade300,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15.0))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image(
                              height: (_stickerSize + 48.0),
                              width: (_stickerSize + 48.0),
                              image: NetworkImage(rawUrl +
                                  '/' +
                                  snapshot.data[_featuredIndex].identifier +
                                  '/' +
                                  snapshot.data[_featuredIndex].trayImageFile),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          snapshot.data[_featuredIndex].name,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w900,
                              fontSize: 24.0,
                              fontStyle: FontStyle.normal,
                              color: Colors.white),
                        ),
                        Text(
                          'Pick of the day',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0,
                              fontStyle: FontStyle.normal,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(4.0),
                                    height: (_stickerSize + 32.0),
                                    width: (_stickerSize + 32.0),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        border: Border.all(
                                            color: Colors.grey.shade300,
                                            width: 1.0),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15.0))),
                                    margin: const EdgeInsets.only(right: 8.0),
                                    child: Image(
                                        image: NetworkImage(rawUrl +
                                            '/' +
                                            snapshot.data[index].identifier +
                                            '/' +
                                            snapshot
                                                .data[index].trayImageFile)),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(snapshot.data[index].name,
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 24.0)),
                                      Text(
                                          snapshot.data[index].stickers.length
                                                  .toString() +
                                              ' stickers',
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18.0,
                                              fontStyle: FontStyle.normal,
                                              color: Colors.grey.shade400)),
                                      Text(snapshot.data[index].publisher,
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.0,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.grey.shade400))
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                children: [
                                  ...snapshot.data[index].stickers
                                      .take(_count)
                                      .map((v) => Padding(
                                            padding: EdgeInsets.only(
                                                right: snapshot.data[index]
                                                            .stickers
                                                            .indexOf(v) ==
                                                        _count - 1
                                                    ? 0.0
                                                    : 8.0),
                                            child: Container(
                                              height: _stickerSize,
                                              width: _stickerSize,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade300,
                                                      width: 1.0),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              15.0))),
                                              child: Image(
                                                  image: NetworkImage(rawUrl +
                                                      '/' +
                                                      snapshot.data[index]
                                                          .identifier +
                                                      '/' +
                                                      v.imageFile)),
                                            ),
                                          )),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
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
