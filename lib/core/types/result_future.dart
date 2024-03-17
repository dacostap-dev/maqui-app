import 'package:fpdart/fpdart.dart';
import 'package:maqui/core/errors/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
