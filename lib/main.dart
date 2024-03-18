import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maqui/core/observers/bloc_observer.dart';
import 'package:maqui/core/router.dart';
import 'package:maqui/data/repository/pokemon_repository_impl.dart';
import 'package:maqui/data/repository/time_repository_impl.dart';
import 'package:maqui/domain/respitory/pokemon_repository.dart';
import 'package:maqui/domain/respitory/time_repository.dart';
import 'package:maqui/features/auth/bloc/splash_bloc.dart';
import 'package:maqui/features/auth/pages/splash.dart';
import 'package:maqui/features/pokemon/bloc/pokemon_bloc.dart';

void main() {
  Bloc.observer = MyBlocObserver();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TimeRepository>(
          create: (context) => TimeRepositoryImplementation(),
        ),
        RepositoryProvider<PokemonRepository>(
          create: (context) => PokemonRepositoryImplementation(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

final _navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SplashBloc(context.read()),
        ),
        BlocProvider(
          create: (context) => PokemonBloc(context.read()),
        ),
      ],
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          (switch (state) {
            SplashComplete() => _navigatorKey.currentState
                ?.pushNamedAndRemoveUntil('pokemons', (route) => false),
            _ => null
          });
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: _navigatorKey,
          title: 'Maqui App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: SplashPage.route,
          onGenerateRoute: onGenerateRoute,
        ),
      ),
    );
  }
}
