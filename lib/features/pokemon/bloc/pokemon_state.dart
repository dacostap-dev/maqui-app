part of 'pokemon_bloc.dart';

sealed class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object> get props => [];
}

final class PokemonInitial extends PokemonState {}

final class PokemonLoading extends PokemonState {}

final class PokemonLoaded extends PokemonState {
  final List<Pokemon> pokemons;
  final bool hasReachedMax;

  const PokemonLoaded({
    required this.pokemons,
    this.hasReachedMax = false,
  });

  @override
  List<Object> get props => [pokemons, hasReachedMax];
}

final class PokemonLoadFailed extends PokemonState {
  final String message;

  const PokemonLoadFailed({required this.message});

  @override
  List<Object> get props => [message];
}

final class PokemonExtraLoading extends PokemonState {}

///DETAIL

final class PokemonDetailLoading extends PokemonState {}

final class PokemonDetailLoaded extends PokemonState {
  final PokemonDetail pokemon;

  const PokemonDetailLoaded({
    required this.pokemon,
  });

  @override
  List<Object> get props => [pokemon];
}

final class PokemonDetailLoadFailed extends PokemonState {
  final String message;

  const PokemonDetailLoadFailed({required this.message});

  @override
  List<Object> get props => [message];
}
