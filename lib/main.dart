import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maqui/core/router.dart';
import 'package:maqui/data/repository/time_repository_impl.dart';
import 'package:maqui/domain/respitory/time_repository.dart';
import 'package:maqui/features/auth/bloc/splash_bloc.dart';

void main() {
  runApp(
    RepositoryProvider<TimeRepository>(
      create: (context) => TimeRepositoryImplementation(),
      child: const MyApp(),
    ),
  );
}

final _navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc(context.read()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          (switch (state) {
            SplashComplete() =>
              _navigatorKey.currentState?.pushNamed('pokemons'),
            _ => null
          });
        },
        child: MaterialApp(
          navigatorKey: _navigatorKey,
          title: 'Maqui App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: '/',
          onGenerateRoute: onGenerateRoute,
        ),
      ),
    );
  }
}
