import 'package:equatable/equatable.dart';
import 'package:maqui/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  final int statusCode;
  final String message;

  const Failure({required this.statusCode, required this.message});

  @override
  List<Object?> get props => [statusCode, message];
}

class ApiFailure extends Failure {
  const ApiFailure({
    required super.statusCode,
    required super.message,
  });

  factory ApiFailure.fromException(ApiException e) => ApiFailure(
        statusCode: e.statusCode,
        message: e.message,
      );
}
