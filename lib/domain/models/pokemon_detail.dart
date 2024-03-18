import 'package:equatable/equatable.dart';

class PokemonDetail extends Equatable {
  final int baseExperience;
  final int height;
  final int id;
  final bool isDefault;
  final String name;
  final int order;
  final int weight;
  final List<PokemonType> types;

  const PokemonDetail({
    required this.baseExperience,
    required this.height,
    required this.id,
    required this.isDefault,
    required this.name,
    required this.order,
    required this.weight,
    required this.types,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) => PokemonDetail(
        baseExperience: json["base_experience"],
        height: json["height"],
        id: json["id"],
        isDefault: json["is_default"],
        name: json["name"],
        order: json["order"],
        weight: json["weight"],
        types: List<PokemonType>.from(
          json["types"].map((x) => PokemonType.fromJson(x)),
        ),
      );

  @override
  // TODO: implement props
  List<Object?> get props =>
      [baseExperience, height, id, isDefault, name, order, weight, types];
}

class PokemonType extends Equatable {
  final Type type;

  const PokemonType({
    required this.type,
  });

  factory PokemonType.fromJson(Map<String, dynamic> json) => PokemonType(
        type: Type.fromJson(json["type"]),
      );

  @override
  List<Object?> get props => [type];
}

class Type extends Equatable {
  final String name;

  const Type({required this.name});

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        name: json["name"],
      );

  @override
  List<Object?> get props => [name];
}
