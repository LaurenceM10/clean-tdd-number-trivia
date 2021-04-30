import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_tdd/src/core/error/failures.dart';
import 'package:flutter_clean_architecture_tdd/src/core/util/input_converter.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsignedInteger', () {
    test('should return an integer when string represent a positive integer', () {
      // arrange
      final str = '123';

      // act
      final result = inputConverter.stringToUnsignedInteger(str);

      // expect
      expect(result, Right(123));
    });

    test('should return a Failure when string is a negative integer', () {
      // arrange
      final str = '-123';

      // act
      final result = inputConverter.stringToUnsignedInteger(str);

      // expect
      expect(result, Left(InvalidInputFailure()));
    });

    test('should return a Failure when string is not a number', () {
      // arrange
      final str = '-abc';

      // act
      final result = inputConverter.stringToUnsignedInteger(str);

      // expect
      expect(result, Left(InvalidInputFailure()));
    });
  });
}