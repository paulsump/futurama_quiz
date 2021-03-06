// © 2022, Paul Sumpner <sumpner@hotmail.com>

import 'package:futurama_quiz/strings.dart';

/// Biography info adapted from API
class Character {
  Character.fromJson(Map<String, dynamic> json)
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

  String get occupation => _occupation.isEmpty ? '' : '$_occupation.';

  List<String> get sayings => _sayings.sayings;

  String get type {
    var s = '$_species $_gender';

    if (_homePlanet.isNotEmpty) {
      s += ' ${Strings.from} $_homePlanet.';
    } else {
      s += '.';
    }
    return s;
  }
}

/// loads all the sayings and gives access to the 5 shortest ones.
class _Sayings {
  _Sayings(this._sayings);

  final List<dynamic> _sayings;

  List<String> get sayings {
    final list = <String>[];

    const int n = 5;

    for (final length in [30, 40, 999]) {
      for (final s in getShortSayings(length)) {
        if (!list.contains(s)) {
          list.add(s);
        }

        if (list.length == n) {
          return list;
        }
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

/// Load the first, middle and last names, then
/// provides the concatenated name.
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

/// Loads two fields, but only returns the main one
/// since the other one is always empty.
/// It's better to leave it rather than guess what might happen in the future(rama).
class _Images {
  _Images.fromJson(Map<String, dynamic> json)
      : headShot = json['head-shot'],
        main = json['main'];

  // "head-shot" is always empty at the time of writing.
  final String headShot, main;

  String get image => main;
}
