// © 2022, Paul Sumpner <sumpner@hotmail.com>

class Info {
  Info.fromJson(Map<String, dynamic> json)
      //TODO CHeck if containsKey()
      : synopsis = json['synopsis'],
        yearsAired = json['yearsAired'],
        creators = json['creators']
            .map<_Creator>(
                (creator) => _Creator(creator['name'], creator['url']))
            .toList(),
        id = json['id'];

  final String synopsis;
  final String yearsAired;
  final List<_Creator> creators;
  final int id;
}

class _Creator {
  _Creator(this.name, this.url);

  final String name;
  final String url;
}
