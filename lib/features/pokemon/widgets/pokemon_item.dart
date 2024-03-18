import 'package:flutter/material.dart';
import 'package:maqui/core/constants/constants.dart';
import 'package:maqui/domain/models/pokemon.dart';
import 'package:maqui/features/pokemon/pages/pokemon_detail.dart';
import 'package:maqui/features/widgets/custom_cached_network_image.dart';

class PokemonItem extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonItem({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    String getPokemonIdFromUrl(String url) {
      final parts = url.split('/');
      return parts[parts.length - 2];
    }

    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, PokemonDetail.route,
            arguments: getPokemonIdFromUrl(pokemon.url));
      },
      leading: CustomCachedNetworkImage(
        imageUrl:
            '${AppConstants.pokemonImage}/${getPokemonIdFromUrl(pokemon.url)}.png',
        height: 70,
        width: 70,
      ),
      title: Text(pokemon.name),
    );
  }
}
