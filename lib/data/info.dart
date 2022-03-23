// © 2022, Paul Sumpner <sumpner@hotmail.com>

class Creator {
  final String name;
  final String url;

  Creator(this.name, this.url);
}

class Info {
  final String synopsis;
  final String yearsAired;
  final List<Creator> creators;
  final int id;

  Info(this.synopsis, this.yearsAired, this.creators, this.id);

  Info.fromJson(Map<String, dynamic> json)
      : synopsis = json['ssynopsis'],
        yearsAired = json['yearsAired'],
        creators = json['creators']
            .map((creator) => Creator(creator['name'], creator['url'])),
        id = json['id'];
}
