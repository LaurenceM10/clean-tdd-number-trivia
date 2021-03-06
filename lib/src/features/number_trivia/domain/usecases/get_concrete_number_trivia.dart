import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_clean_architecture_tdd/src/core/usecases/use_case.dart';
import 'package:flutter_clean_architecture_tdd/src/core/error/failures.dart';
import 'package:flutter_clean_architecture_tdd/src/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture_tdd/src/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await this.repository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;

  Params({
    @required this.number
  });

  @override
  List<Object> get props => [number];
}