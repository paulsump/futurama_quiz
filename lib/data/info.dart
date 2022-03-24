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
  final List<Creator> creators;
  final int id;

  Info(this.synopsis, this.yearsAired, this.creators, this.id);

  Info.fromJson(Map<String, dynamic> json)
      //TODO CHeck if containsKey()
      : synopsis = json['synopsis'],
        yearsAired = json['yearsAired'],
        creators = json['creators']
            .map<Creator>((creator) => Creator(creator['name'], creator['url']))
            .toList(),
        id = json['id'];
}

class Creator {
  final String name;
  final String url;

  Creator(this.name, this.url);
}
