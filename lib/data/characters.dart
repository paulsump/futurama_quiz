import 'package:futurama_quiz/data/fetcher.dart';

Future<List<Character>> fetchCharacters(Fetcher fetcher) async {
  final list = await fetcher.getList('characters');

  return list.map((character) => Character.fromJson(character)).toList();
}

class Character {
  Character.fromJson(Map<String, dynamic> json) {}
// final String name;
// final String image;
// final String gender;
// final String species;

// final String homePlanet;
// final String occupation;
}
