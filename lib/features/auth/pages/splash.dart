import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maqui/core/constants/constants.dart';
import 'package:maqui/features/auth/bloc/splash_bloc.dart';
import 'package:maqui/features/widgets/custom_cached_network_image.dart';

class SplashPage extends StatefulWidget {
  static const String route = 'splash';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SplashBloc>().add(const GetTimeZone());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.2, 0.95],
            colors: [Color.fromARGB(153, 39, 156, 210), Colors.white],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: constraints.maxHeight / 3),
                  const CustomCachedNetworkImage(
                    imageUrl: AppConstants.logoUrl,
                    height: 100,
                  ),
                  const Spacer(),
                  BlocBuilder<SplashBloc, SplashState>(
                    buildWhen: (previous, current) => switch (current) {
                      SplashLoadedTime() => true,
                      _ => false,
                    },
                    builder: (context, state) {
                      return switch (state) {
                        SplashLoadedTime() => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              state.time,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 26, 95, 151),
                              ),
                            ),
                          ),
                        _ => const SizedBox()
                      };
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
