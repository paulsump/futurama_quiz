import 'package:futurama_quiz/out.dart';

const noWarn = out;

class Character {
  Character.fromJson(Map<String, dynamic> json)
      //TODO containsKey
      : _name = _Name.fromJson(json['name']),
        _images = _Images.fromJson(json['images']),
        gender = json['gender'],
        species = json['species'],
        homePlanet = json.containsKey('homePlanet') ? json['homePlanet'] : '',
        occupation = json['occupation'],
        _sayings = _Sayings(json['sayings']);

  final String gender;
  final String species;

  final String homePlanet;
  final String occupation;

  final _Name _name;
  final _Images _images;
  final _Sayings _sayings;

  String get name => _name.fullName;

  String get image => _images.image;

  List<String> get sayings => _sayings.sayings;
}

class _Sayings {
  _Sayings(this._sayings);

  final List<dynamic> _sayings;

  bool get hasShortSayings => shortSayings.isNotEmpty;

  List<String> get sayings {
    if (hasShortSayings) {
      return shortSayings;
    }

    final medium = getShortSayings(40).toList();

    if (medium.isNotEmpty) {
      return medium;
    }

    return _sayings.map<String>((s) => s.toString()).toList();
  }

  List<String> get shortSayings => getShortSayings(30).toList();

  Iterable<String> getShortSayings(int length) sync* {
    for (dynamic saying in _sayings) {
      final shortSaying = saying.toString();

      if (shortSaying.length < length) {
        yield '"$shortSaying"';
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

  String get fullName =>
      middle.isEmpty ? '$first $last' : '$first $middle $last';
}

class _Images {
  _Images.fromJson(Map<String, dynamic> json)
      : headShot = json['head-shot'],
        main = json['main'];

  //"head-shot" i always empty?
  final String headShot, main;

  String get image => main;
}