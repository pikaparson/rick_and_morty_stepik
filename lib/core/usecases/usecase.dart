import 'package:dartz/dartz.dart';

import '../error/failure.dart';

abstract class UseCase<Type, Params> { // Type - тип возврата без ошибок, Params - вернет некоторые изменения кода в usecases
  Future<Either<Failure, Type>> call(Params params);
}