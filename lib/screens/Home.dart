import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:stickerbaba/models/sticker.dart';

class Home extends StatefulWidget {

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String rawUrl = "https://raw.githubusercontent.com/moaj257/stickerbaba/master/assets";
  String url = "https://github.com/moaj257/stickerbaba/blob/master/assets";
  List<dynamic> stickerList = <Sticker>[];
  bool isLoading = true;

  void getData() async {
    setState(() {isLoading = true;});
    var res = await http
      .get(Uri.parse('$rawUrl/contents.json'), headers: {"Accept": "application/json"});
    if(res.statusCode == 200) {
      stickerList = json.decode(res.body)['sticker_packs']
          .map((data) => Sticker.fromJson(data))
          .toList();
      setState(() {isLoading = false;});
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading ? 
        const Center(
          child: CircularProgressIndicator(),
        ) : 
        Container(
          child: ListView.builder(
            itemCount: stickerList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(stickerList[index].name),
                subtitle: Text(stickerList[index].publisher),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(rawUrl + '/' + stickerList[index].identifier + '/' + stickerList[index].trayImageFile),
                ),
              );
            })   
        ),
    );
  }
}
