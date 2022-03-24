// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'package:futurama_quiz/data/fetcher.dart';

Future<Info> fetchInfo(Fetcher fetcher) async {
  final list = await fetcher.getList('info');

  assert(list.length == 1);
  return Info.fromJson(list[0]);
}

class Info {
  final String synopsis;
  final String yearsAired;
  final List<_Creator> creators;
  final int id;


  Info.fromJson(Map<String, dynamic> json)
      //TODO CHeck if containsKey()
      : synopsis = json['synopsis'],
        yearsAired = json['yearsAired'],
        creators = json['creators']
            .map<_Creator>(
                (creator) => _Creator(creator['name'], creator['url']))
            .toList(),
        id = json['id'];
}

class _Creator {
  final String name;
  final String url;

  _Creator(this.name, this.url);
}
