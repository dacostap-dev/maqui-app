part of 'pokemon_bloc.dart';

sealed class PokemonEvent extends Equatable {
  const PokemonEvent();

  factory PokemonEvent.getPokemons() => GetPokemons();
  factory PokemonEvent.getMorePokemons() => GetMorePokemons();
  factory PokemonEvent.getPokemonDetail({required String id}) =>
      GetPokemonDetail(id: id);

  @override
  List<Object> get props => [];
}

final class GetPokemons extends PokemonEvent {}

final class GetMorePokemons extends PokemonEvent {}

final class FilterPokemons extends PokemonEvent {
  final String search;

  const FilterPokemons({required this.search});

  @override
  List<Object> get props => [search];
}

//DETAIL

final class GetPokemonDetail extends PokemonEvent {
  final String id;

  const GetPokemonDetail({required this.id});

  @override
  List<Object> get props => [id];
}
