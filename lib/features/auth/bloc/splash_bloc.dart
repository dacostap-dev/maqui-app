import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maqui/domain/respitory/time_repository.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final TimeRepository _timeRepository;

  SplashBloc(this._timeRepository) : super(SplashInitial()) {
    on<GetTimeZone>(_getTimeZone);
  }

  void _getTimeZone(GetTimeZone event, Emitter<SplashState> emitter) async {
    final res = await _timeRepository.getTime();

    res.fold(
      (l) => SplashLoadedTimeError(message: l.message),
      (res) => emitter(SplashLoadedTime(time: '${res.date} ${res.time}')),
    );

    await Future.delayed(const Duration(seconds: 3));

    emitter(SplashComplete());
  }
}
