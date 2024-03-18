import 'package:flutter/material.dart';
import 'package:maqui/features/auth/pages/splash.dart';
import 'package:maqui/features/pokemon/pages/pokemon_detail.dart';
import 'package:maqui/features/pokemon/pages/pokemons.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashPage.route:
      return MaterialPageRoute(builder: (_) => const SplashPage());
    case PokemonsPage.route:
      return MaterialPageRoute(builder: (_) => const PokemonsPage());
    case PokemonDetail.route:
      final id = settings.arguments as String;

      return MaterialPageRoute(builder: (_) => PokemonDetail(pokemonId: id));
    default:
      throw ('This route nae does not exist');
  }
}
