part of 'splash_bloc.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

final class SplashInitial extends SplashState {}

final class SplashLoading extends SplashState {}

final class SplashLoadedTime extends SplashState {
  final String time;

  const SplashLoadedTime({required this.time});

  @override
  List<Object> get props => [time];
}

final class SplashLoadedTimeError extends SplashState {
  final String message;

  const SplashLoadedTimeError({required this.message});

  @override
  List<Object> get props => [message];
}

final class SplashComplete extends SplashState {}
