import 'package:futurama_quiz/data/fetcher.dart';
import 'package:futurama_quiz/out.dart';

const noWarn = out;

Future<List<Character>> fetchCharacters(Fetcher fetcher) async {
  final list = await fetcher.getList('characters');

  // out(list[0]['sayings']);
  return list.map((character) => Character.fromJson(character)).toList();
}

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

  String get name => _name.fullName;

  String get image => _images.image;

  final String gender;
  final String species;

  final String homePlanet;
  final String occupation;

  List<String> get sayings => _sayings.sayings;

  final _Name _name;
  final _Images _images;
  final _Sayings _sayings;
}

class _Sayings {
  _Sayings(this._sayings);

  //TODO fix / decide what i want e.g. random saying
  List<String> get sayings {
    for (dynamic saying in _sayings) {
      out(saying);
      // .map<String>((saying) => saying ?? saying as String)
      // .toList();
    }
    return [];
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
