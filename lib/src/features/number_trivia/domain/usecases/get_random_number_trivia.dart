import 'package:dartz/dartz.dart';

import 'package:flutter_clean_architecture_tdd/src/core/usecases/use_case.dart';
import 'package:flutter_clean_architecture_tdd/src/core/error/failures.dart';
import 'package:flutter_clean_architecture_tdd/src/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture_tdd/src/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await this.repository.getRandomNumberTrivia();
  }
}