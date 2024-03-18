class PokemonResponse {
  int count;
  String next;
  String? previous;
  List<Pokemon> results;

  PokemonResponse({
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
}

class Pokemon {
  String name;
  String url;

  Pokemon({
    required this.name,
    required this.url,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        name: json["name"],
        url: json["url"],
      );
}
