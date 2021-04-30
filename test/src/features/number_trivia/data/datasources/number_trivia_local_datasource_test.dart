import 'dart:convert';

import 'package:flutter_clean_architecture_tdd/src/core/error/exception.dart';
import 'package:flutter_clean_architecture_tdd/src/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:flutter_clean_architecture_tdd/src/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:matcher/matcher.dart';

import '../../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

main() {
  NumberTriviaLocalDataSourceImpl localDataSourceImpl;
  MockSharedPreferences sharedPreferences;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    localDataSourceImpl = NumberTriviaLocalDataSourceImpl(
      sharedPreferences: sharedPreferences,
    );
  });

  group('getLastNumberTrivia', () {
    final tNumberTriviaModel = NumberTriviaModel.fromJson(
        json.decode(fixture('number_trivia_cache.json')));
    test(
        'shoud return last number trivia from SharedPreferences when there is one in cache',
        () async {
      // arrange
      when(sharedPreferences.getString(any))
          .thenReturn(fixture('number_trivia_cache.json'));

      // act
      final result = await localDataSourceImpl.getLastNumberTrivia();

      // assert
      verify(sharedPreferences.getString('CACHED_NUMBER_TRIVIA'));
      expect(result, tNumberTriviaModel);
    });

    test('shoud throw a CacheExpection when there is no data in cache',
        () async {
      // arrange
      when(sharedPreferences.getString(any)).thenReturn(null);

      // act
      final call = localDataSourceImpl.getLastNumberTrivia;

      // assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });

  group('cacheNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel(number: 1, text: 'test trivia');

    test('should call SharedPreferences to cache the data', () {
      // act
      localDataSourceImpl.cacheNumberTrivia(tNumberTriviaModel);
      // assert
      final expectedJsonString = json.encode(tNumberTriviaModel.toJson());
      verify(sharedPreferences.setString(
        'CACHED_NUMBER_TRIVIA',
        expectedJsonString,
      ));
      
    });
  });
}
