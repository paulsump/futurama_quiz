// © 2022, Paul Sumpner <sumpner@hotmail.com>

class Info {
  Info.fromJson(Map<String, dynamic> json)
      //TODO CHeck if containsKey()
      : _synopsis = json['synopsis'],
        yearsAired = json['yearsAired'],
        _creators = json['creators']
            .map<_Creator>(
                (creator) => _Creator(creator['name'], creator['url']))
            .toList(),
        id = json['id'] {
    // TODO PIC for each paragraph
    synopsis = _synopsis.replaceFirst('2999. ', '2999.\n\n');
    synopsis = synopsis.replaceFirst('things. ', 'things.\n\n');
    synopsis = synopsis.replaceFirst('things. ', 'things.\n\n');
    synopsis = synopsis.replaceFirst('forgetful. ', 'forgetful.\n\n');
    synopsis = synopsis.replaceFirst('hip. ', 'hip.\n\n');
    synopsis = synopsis.replaceFirst('look. ', 'look.\n\n');
    synopsis = synopsis.replaceFirst('humans. ', 'humans.\n\n');
  }

  final String _synopsis;
  late String synopsis;
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
