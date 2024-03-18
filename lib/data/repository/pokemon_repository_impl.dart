import 'package:fpdart/fpdart.dart';
import 'package:maqui/core/api/dio.dart';
import 'package:maqui/core/constants/constants.dart';
import 'package:maqui/core/errors/failure.dart';
import 'package:maqui/core/types/result_future.dart';
import 'package:maqui/domain/models/pokemon.dart';
import 'package:maqui/domain/models/pokemon_detail.dart';

import 'package:maqui/domain/respitory/pokemon_repository.dart';

class PokemonRepositoryImplementation implements PokemonRepository {
  @override
  ResultFuture<PokemonResponse> getPokemons({int offset = 0}) async {
    try {
      final res = await Api.instance.dio
          .get('${AppConstants.pokemonApiUrl}/pokemon?limit=20&offset=$offset');
      return right(PokemonResponse.fromJson(res.data));
    } catch (e) {
      return left(ApiFailure(message: e.toString(), statusCode: 505));
    }
  }

  @override
  ResultFuture<PokemonDetail> getPokemonDetail({required String id}) async {
    try {
      final res = await Api.instance.dio
          .get('${AppConstants.pokemonApiUrl}/pokemon/$id');
      return right(PokemonDetail.fromJson(res.data));
    } catch (e) {
      return left(ApiFailure(message: e.toString(), statusCode: 505));
    }
  }
}
