import 'package:flutter/material.dart';
import 'package:maqui/features/auth/pages/splash.dart';
import 'package:maqui/features/pokemon/pages/pokemons.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const SplashPage());
    case 'pokemons':
      return MaterialPageRoute(builder: (_) => const PokemonsPage());
    case 'pokemon/detail':
      return MaterialPageRoute(builder: (_) => const SplashPage());
    default:
      throw ('This route nae does not exist');
  }
}
