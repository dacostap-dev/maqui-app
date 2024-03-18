import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:maqui/domain/models/pokemon.dart';
import 'package:maqui/domain/models/pokemon_detail.dart';
import 'package:maqui/domain/respitory/pokemon_repository.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository _pokemonRepository;

  List<Pokemon> pokemons = [];

  PokemonBloc(this._pokemonRepository) : super(PokemonInitial()) {
    on<GetPokemons>(_getPokemons);
    on<FilterPokemons>(_filterPokemons);
    on<GetPokemonDetail>(_getPokemonDetail);
  }

  bool _hasReachedMax(PokemonState state) =>
      state is PokemonLoaded && state.hasReachedMax;

  _getPokemons(GetPokemons event, Emitter<PokemonState> emitter) async {
    if (_hasReachedMax(state)) return;

    pokemons.isEmpty
        ? emitter(PokemonLoading())
        : emitter(PokemonExtraLoading());

    final res = await _pokemonRepository.getPokemons(offset: pokemons.length);

    res.fold(
      (l) => emitter(PokemonLoadFailed(message: l.message)),
      (response) {
        if (response.results.isEmpty) {
          return emitter(
            PokemonLoaded(
              pokemons: pokemons,
              hasReachedMax: true,
            ),
          );
        }

        pokemons.addAll(response.results);
        emitter(PokemonLoaded(pokemons: pokemons));
      },
    );
  }

  _filterPokemons(FilterPokemons event, Emitter<PokemonState> emitter) async {
    final pokemonsFilteres = pokemons
        .filter((pokemon) => pokemon.name.contains(event.search))
        .toList();

    emitter(
      PokemonLoaded(
          pokemons: event.search.length < 3 ? pokemons : pokemonsFilteres,
          hasReachedMax: event.search.length < 3 ? false : true),
    );
  }

  _getPokemonDetail(
      GetPokemonDetail event, Emitter<PokemonState> emitter) async {
    emitter(PokemonDetailLoading());

    final res = await _pokemonRepository.getPokemonDetail(id: event.id);

    res.fold(
      (l) => emitter(PokemonDetailLoadFailed(message: l.message)),
      (response) {
        emitter(PokemonDetailLoaded(pokemon: response));
      },
    );
  }
}
