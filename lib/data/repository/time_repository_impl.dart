import 'package:fpdart/fpdart.dart';
import 'package:maqui/core/api/dio.dart';
import 'package:maqui/core/constants/constants.dart';
import 'package:maqui/core/errors/failure.dart';
import 'package:maqui/core/types/result_future.dart';
import 'package:maqui/domain/models/time.dart';
import 'package:maqui/domain/respitory/time_repository.dart';

class TimeRepositoryImplementation implements TimeRepository {
  @override
  ResultFuture<TimeModel> getTime() async {
    try {
      final res = await Api.instance.dio.get(AppConstants.timeApiUrl);
      return right(TimeModel.fromJson(res.data));
    } catch (e) {
      return left(ApiFailure(message: e.toString(), statusCode: 505));
    }
  }
}
