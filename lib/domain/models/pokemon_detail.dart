class PokemonDetail {
  int baseExperience;
  int height;
  int id;
  bool isDefault;
  String name;
  int order;
  int weight;

  PokemonDetail({
    required this.baseExperience,
    required this.height,
    required this.id,
    required this.isDefault,
    required this.name,
    required this.order,
    required this.weight,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) => PokemonDetail(
        baseExperience: json["base_experience"],
        height: json["height"],
        id: json["id"],
        isDefault: json["is_default"],
        name: json["name"],
        order: json["order"],
        weight: json["weight"],
      );
}
