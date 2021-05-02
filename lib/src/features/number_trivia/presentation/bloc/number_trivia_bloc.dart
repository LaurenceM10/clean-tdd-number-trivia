import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture_tdd/src/core/usecases/use_case.dart';
import 'package:flutter_clean_architecture_tdd/src/core/util/input_converter.dart';
import 'package:flutter_clean_architecture_tdd/src/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture_tdd/src/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_clean_architecture_tdd/src/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  GetConcreteNumberTrivia getConcreteNumberTrivia;
  GetRandomNumberTrivia getRandomNumberTrivia;
  InputConverter inputConverter;

  NumberTriviaBloc({
    @required this.getConcreteNumberTrivia,
    @required this.getRandomNumberTrivia,
    @required this.inputConverter,
  }) : super(Empty());

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetTriviaForConcreteNumber) {
      final inputEither = inputConverter.stringToUnsignedInteger(event.number);

      yield* inputEither.fold(
        (failure) async* {
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
        },
        (integer) async* {
          yield Loading();

          final failureOrTrivia =
              await getConcreteNumberTrivia(Params(number: integer));

          yield failureOrTrivia.fold(
            (failure) => Error(message: SERVER_FAILURE_MESSAGE),
            (trivia) => Loaded(numberTrivia: trivia),
          );
        },
      );
    }

    if (event is GetTriviaForRandom) {
      yield Loading();

      final failureOrTrivia = await getRandomNumberTrivia(NoParams());

      yield failureOrTrivia.fold(
        (failure) => Error(message: SERVER_FAILURE_MESSAGE),
        (trivia) => Loaded(numberTrivia: trivia),
      );
    }
  }
}
