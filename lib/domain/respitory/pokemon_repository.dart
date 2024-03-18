import 'package:maqui/core/types/result_future.dart';
import 'package:maqui/domain/models/pokemon.dart';
import 'package:maqui/domain/models/pokemon_detail.dart';

abstract interface class PokemonRepository {
  ResultFuture<PokemonResponse> getPokemons({int offset = 0});
  ResultFuture<PokemonDetail> getPokemonDetail({required String id});
}
