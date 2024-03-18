import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maqui/core/constants/constants.dart';
import 'package:maqui/features/pokemon/bloc/pokemon_bloc.dart';
import 'package:maqui/features/widgets/custom_cached_network_image.dart';

class PokemonDetail extends StatefulWidget {
  static const String route = 'pokemon-detail';

  final String pokemonId;

  const PokemonDetail({super.key, required this.pokemonId});

  @override
  State<PokemonDetail> createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<PokemonBloc>().add(GetPokemonDetail(id: widget.pokemonId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Pokemon'),
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          return switch (state) {
            PokemonDetailLoaded() => Container(
                // color: Colors.green,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomCachedNetworkImage(
                      imageUrl:
                          '${AppConstants.pokemonImage}/${widget.pokemonId}.png',
                      height: 250,
                      width: 250,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nombre: ${state.pokemon.name}',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Altura: ${state.pokemon.height.toString()}',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Peso: ${state.pokemon.weight.toString()}',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            PokemonDetailLoading() =>
              const Center(child: CircularProgressIndicator()),
            _ => const SizedBox()
          };
        },
      ),
    );
  }
}
