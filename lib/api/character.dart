import 'package:futurama_quiz/out.dart';

const noWarn = out;

class Character {
  Character.fromJson(Map<String, dynamic> json)
      //TODO containsKey
      : _name = _Name.fromJson(json['name']),
        _images = _Images.fromJson(json['images']),
        gender = json['gender'],
        species = json['species'],
        homePlanet =
            json.containsKey('homePlanet') ? json['homePlanet'] : 'Unknown',
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

  bool get hasShortSayings => shortSayings.isNotEmpty;

  List<String> get sayings {
    if (hasShortSayings) {
      return shortSayings;
    } else {
      return _sayings.map<String>((s) => s.toString()).toList();
    }
  }

  List<String> get shortSayings => _shortSayings.toList();

  Iterable<String> get _shortSayings sync* {
    for (dynamic saying in _sayings) {
      final shortSaying = saying.toString();

      if (shortSaying.length < 30) {
        yield shortSaying;
      }
    }
  }

  final List<dynamic> _sayings;
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
