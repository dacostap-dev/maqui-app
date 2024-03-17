import 'package:maqui/core/types/result_future.dart';
import 'package:maqui/domain/models/time.dart';

abstract interface class TimeRepository {
  ResultFuture<TimeModel> getTime();
}
