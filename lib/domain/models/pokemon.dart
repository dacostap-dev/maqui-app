import 'package:equatable/equatable.dart';

class PokemonResponse extends Equatable {
  final int count;
  final String next;
  final String? previous;
  final List<Pokemon> results;

  const PokemonResponse({
    required this.count,
    required this.next,
    this.previous,
    required this.results,
  });

  factory PokemonResponse.fromJson(Map<String, dynamic> json) =>
      PokemonResponse(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Pokemon>.from(
          json["results"].map((x) => Pokemon.fromJson(x)),
        ),
      );

  @override
  List<Object?> get props => [count, next, previous, results];
}

class Pokemon extends Equatable {
  final String name;
  final String url;

  const Pokemon({
    required this.name,
    required this.url,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        name: json["name"],
        url: json["url"],
      );

  @override
  List<Object?> get props => [name, url];
}
