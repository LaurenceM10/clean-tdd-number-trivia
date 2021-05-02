import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_tdd/src/core/error/failures.dart';
import 'package:flutter_clean_architecture_tdd/src/core/usecases/use_case.dart';
import 'package:flutter_clean_architecture_tdd/src/core/util/input_converter.dart';
import 'package:flutter_clean_architecture_tdd/src/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture_tdd/src/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_clean_architecture_tdd/src/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:flutter_clean_architecture_tdd/src/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaBloc bloc;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
        getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
        getRandomNumberTrivia: mockGetRandomNumberTrivia,
        inputConverter: mockInputConverter);
  });

  test('initialState should be [Empty]', () {
    expect(bloc.state, equals(Empty()));
  });

  group('GetConcreteNumberTrivia', () {
    final tNumberString = '1';
    final tNumberParsed = int.parse(tNumberString);
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    blocTest(
      'shoul emit [Error] when the input is invalid',
      build: () {
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Left(InvalidInputFailure()));
        return bloc;
      },
      act: (bloc) =>
          bloc.add(GetTriviaForConcreteNumber(number: tNumberString)),
      expect: () => [Error(message: INVALID_INPUT_FAILURE_MESSAGE)],
    );

    blocTest(
      'should get data from GetConcreteNumberTrivia usecase',
      build: () {
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tNumberParsed));
        when(mockGetConcreteNumberTrivia.call(any))
            .thenAnswer((_) async => Right(tNumberTrivia));

        return bloc;
      },
      act: (bloc) =>
          bloc.add(GetTriviaForConcreteNumber(number: tNumberString)),
      verify: (_) {
        verify(mockGetConcreteNumberTrivia(Params(number: tNumberParsed)));
      },
    );

    blocTest(
      'should emit [Loading, Loaded]  when data is gotten successfully',
      build: () {
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tNumberParsed));
        when(mockGetConcreteNumberTrivia.call(any))
            .thenAnswer((_) async => Right(tNumberTrivia));

        return bloc;
      },
      act: (bloc) =>
          bloc.add(GetTriviaForConcreteNumber(number: tNumberString)),
      expect: () => [Loading(), Loaded(numberTrivia: tNumberTrivia)],
    );

    blocTest(
      'should emit [Loading, Error] when getting data fails caused by ServerFailure',
      build: () {
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tNumberParsed));
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Left(ServerFailure()));

        return bloc;
      },
      act: (bloc) =>
          bloc.add(GetTriviaForConcreteNumber(number: tNumberString)),
      expect: () => [Loading(), Error(message: SERVER_FAILURE_MESSAGE)],
    );

    blocTest(
      'should emit [Loading, Error] when getting data fails caused by CacheFailure',
      build: () {
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tNumberParsed));
        when(mockGetConcreteNumberTrivia(any))
            .thenAnswer((_) async => Left(CacheFailure()));

        return bloc;
      },
      act: (bloc) =>
          bloc.add(GetTriviaForConcreteNumber(number: tNumberString)),
      expect: () => [Loading(), Error(message: CACHE_FAILURE_MESSAGE)],
    );
  });

  group('GetRandomNumberTrivia', () {
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test trivia');

    blocTest(
      'should get data from GetRandomNumberTrivia use case',
      build: () {
        when(mockGetRandomNumberTrivia.call(any))
            .thenAnswer((_) async => Right(tNumberTrivia));

        return bloc;
      },
      act: (bloc) => bloc.add(GetTriviaForRandom()),
      verify: (_) {
        verify(mockGetRandomNumberTrivia(NoParams()));
      },
    );


    blocTest(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetRandomNumberTrivia.call(any))
            .thenAnswer((_) async => Right(tNumberTrivia));

        return bloc;
      },
      act: (bloc) => bloc.add(GetTriviaForRandom()),
      expect: () => [Loading(), Loaded(numberTrivia: tNumberTrivia)],
    );

    blocTest(
      'should emit [Error] when getting data fails',
      build: () {
        when(mockGetRandomNumberTrivia.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));

        return bloc;
      },
      act: (bloc) => bloc.add(GetTriviaForRandom()),
      expect: () => [Loading(), Error(message: SERVER_FAILURE_MESSAGE)],
    );

  });
}
