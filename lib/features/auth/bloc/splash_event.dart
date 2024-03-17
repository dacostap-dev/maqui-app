part of 'splash_bloc.dart';

sealed class SplashEvent extends Equatable {
  const SplashEvent();

  factory SplashEvent.getTimeZone() => const GetTimeZone();

  @override
  List<Object> get props => [];
}

final class GetTimeZone extends SplashEvent {
  const GetTimeZone();
}
