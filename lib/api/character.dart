import 'package:futurama_quiz/out.dart';

const noWarn = out;

class Character {
  Character.fromJson(Map<String, dynamic> json)
      //TODO containsKey
      : _name = _Name.fromJson(json['name']),
        _images = _Images.fromJson(json['images']),
        _gender = json['gender'],
        _species = json['species'],
        _homePlanet = json.containsKey('homePlanet') ? json['homePlanet'] : '',
        _occupation = json['occupation'],
        _sayings = _Sayings(json['sayings']);

  final String _gender;
  final String _species;

  final String _homePlanet;
  final String _occupation;

  final _Name _name;
  final _Images _images;
  final _Sayings _sayings;

  String get name => _name.fullName;

  String get image => _images.image;

  String get occupation => '$_occupation.';

  List<String> get sayings => _sayings.sayings;

  String get type {
    var s = '$_species $_gender';

    if (_homePlanet.isNotEmpty) {
      s += ' from $_homePlanet.';
    }
    return s;
  }
}

class _Sayings {
  _Sayings(this._sayings);

  final List<dynamic> _sayings;

  List<String> get sayings {
    final list = <String>[];

    const int n = 5;
//TODO TIdy this up
    for (final s in getShortSayings(30)) {
      list.add(s);

      if (list.length == n) {
        return list;
      }
    }

    for (final s in getShortSayings(40)) {
      if (!list.contains(s)) {
        list.add(s);
      }

      if (list.length == n) {
        return list;
      }
    }

    for (final s in _sayings.map<String>((s) => s.toString())) {
      if (!list.contains(s)) {
        list.add(s);
      }

      if (list.length == n) {
        return list;
      }
    }

    return list;
  }


  Iterable<String> getShortSayings(int length) sync* {
    for (dynamic saying in _sayings) {
      final shortSaying = saying.toString();

      if (shortSaying.length < length) {
        yield shortSaying;
      }
    }
  }
}

class _Name {
  _Name.fromJson(Map<String, dynamic> json)
      : first = json['first'],
        middle = json['middle'],
        last = json['last'];

  final String first, middle, last;

  String get fullName {
    var s = '$first ';

    if (middle.isNotEmpty) {
      s += '$middle ';
    }

    return s + '$last.';
  }
}

class _Images {
  _Images.fromJson(Map<String, dynamic> json)
      : headShot = json['head-shot'],
        main = json['main'];

  //TODO check if "head-shot" is always empty?
  final String headShot, main;

  String get image => main;
}
