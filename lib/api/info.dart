// © 2022, Paul Sumpner <sumpner@hotmail.com>

class Info {
  Info.fromJson(Map<String, dynamic> json)
      //TODO CHeck if containsKey()
      : synopsis = json['synopsis'],
        yearsAired = json['yearsAired'],
        _creators = json['creators']
            .map<_Creator>(
                (creator) => _Creator(creator['name'], creator['url']))
            .toList(),
        id = json['id'];

  final String synopsis;
  final String yearsAired;

  Iterable<String> get creatorNames sync* {
    for (final creator in _creators) {
      yield creator.name;
    }
  }

  final int id;

  final List<_Creator> _creators;
}

class _Creator {
  _Creator(this.name, this.url);

  final String name;
  final String url;
}
