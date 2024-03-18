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
      context
          .read<PokemonBloc>()
          .add(PokemonEvent.getPokemonDetail(id: widget.pokemonId));
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 105, 176, 235),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          return switch (state) {
            PokemonDetailLoaded() => Stack(
                alignment: Alignment.center,
                children: [
                  const Positioned(
                    top: 40,
                    left: 1,
                    child: BackButton(color: Colors.white),
                  ),
                  Positioned(
                      top: 90,
                      left: 20,
                      child: Text(
                        state.pokemon.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      )),
                  Positioned(
                    top: 140,
                    left: 20,
                    child: Row(
                      children: [
                        ...state.pokemon.types
                            .map(
                              (pokeType) => Container(
                                margin: const EdgeInsets.only(right: 8),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  color: Colors.black26,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Text(
                                    pokeType.type.name,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                            .take(2),
                      ],
                    ),
                  ),
                  Positioned(
                    top: height * 0.18,
                    right: -30,
                    child: Image.asset(
                      "assets/images/pokeball.png",
                      height: 200,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                        width: width,
                        height: height * 0.6,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: width * 0.3,
                                  child: const Text("Nombre",
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 18,
                                      )),
                                ),
                                Text(
                                  state.pokemon.name,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: width * 0.3,
                                  child: const Text("Altura",
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 18,
                                      )),
                                ),
                                Text(
                                  state.pokemon.height.toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: width * 0.3,
                                  child: const Text("Peso",
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 18,
                                      )),
                                ),
                                Text(
                                  state.pokemon.weight.toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        )),
                  ),
                  Positioned(
                    top: height * 0.18,
                    left: (width / 2) - 100,
                    child: CustomCachedNetworkImage(
                      imageUrl:
                          '${AppConstants.pokemonImage}/${widget.pokemonId}.png',
                      height: 200,
                      width: 200,
                      // fit: BoxFit.fitHeight,
                    ),
                  )
                ],
              ),
            PokemonDetailLoading() => const Center(
                child: CircularProgressIndicator(color: Colors.white)),
            PokemonDetailLoadFailed() => Center(child: Text(state.message)),
            _ => const SizedBox()
          };
        },
      ),
    );
  }
}
