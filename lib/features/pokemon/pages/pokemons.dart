import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maqui/features/pokemon/bloc/pokemon_bloc.dart';
import 'package:maqui/features/pokemon/widgets/bottom_loader.dart';
import 'package:maqui/features/pokemon/widgets/pokemon_item.dart';
import 'package:maqui/features/pokemon/widgets/pokemon_item_skeleton.dart';

class PokemonsPage extends StatefulWidget {
  static const String route = 'pokemons';

  const PokemonsPage({super.key});

  @override
  State<PokemonsPage> createState() => _PokemonsPageState();
}

class _PokemonsPageState extends State<PokemonsPage> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  // final _scrollThreshold = 200.0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PokemonBloc>().add(PokemonEvent.getPokemons());
    });

    _scrollController.addListener(onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();

    _scrollController.removeListener(onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  onScroll() {
    if (_scrollController.hasClients) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;

      // print('maxScroll: $maxScroll');
      // print('currentScroll: $currentScroll');

      if (maxScroll == currentScroll) {
        print('load-more');
        context.read<PokemonBloc>().add(PokemonEvent.getMorePokemons());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PokemonBloc, PokemonState>(
      listener: (context, state) {
        (switch (state) {
          PokemonLoadFailed(message: final message) =>
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            ),
          _ => null,
        });
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pokemons'),
        ),
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              sliver: SliverToBoxAdapter(
                child: TextFormField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    isDense: true,
                    hintText: 'Buscar pokemon',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    context
                        .read<PokemonBloc>()
                        .add(FilterPokemons(search: value.trim()));
                  },
                ),
              ),
            ),
            BlocBuilder<PokemonBloc, PokemonState>(
              buildWhen: (previous, current) => switch (current) {
                PokemonExtraLoading() => false,
                PokemonDetailLoading() => false,
                PokemonDetailLoadFailed(message: _) => false,
                PokemonDetailLoaded(pokemon: _) => false,
                _ => true,
              },
              builder: (context, state) {
                // print(state);
                return switch (state) {
                  PokemonLoaded(pokemons: final pokemons) => SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return index >= pokemons.length
                              ? const BottomLoader()
                              : PokemonItem(pokemon: pokemons[index]);
                        },
                        childCount: state.hasReachedMax
                            ? pokemons.length
                            : pokemons.length + 1,
                      ),
                    ),
                  PokemonLoading() => SliverList(
                      delegate: SliverChildListDelegate(
                        List.generate(
                          10,
                          (int index) => const PokemonItemSkeleton(),
                        ),
                      ),
                    ),
                  PokemonLoadFailed(message: final message) => Center(
                      child: SliverToBoxAdapter(child: Text(message)),
                    ),
                  _ => const SliverToBoxAdapter(child: SizedBox.shrink()),
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}
