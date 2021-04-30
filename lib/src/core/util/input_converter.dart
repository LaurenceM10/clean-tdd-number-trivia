import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_tdd/src/core/error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      final number = int.parse(str);
      if(number < 0) throw FormatException();

      return Right(number);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}
