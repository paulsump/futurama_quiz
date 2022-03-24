// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'package:flutter/material.dart';
import 'package:futurama_quiz/data/fetcher.dart';
import 'package:futurama_quiz/data/info.dart';
import 'package:futurama_quiz/view/info_view.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Info> info;

  @override
  void initState() {
    final client = http.Client();

    final fetcher = Fetcher(client);
    info = fetchInfo(fetcher);

    client.close();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InfoView(info: info),
          ],
        ),
      ),
    );
  }
}
