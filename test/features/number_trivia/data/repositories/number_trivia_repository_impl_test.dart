import 'package:flutter_clean_architecture_tdd/src/core/platform/network_info.dart';
import 'package:flutter_clean_architecture_tdd/src/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:flutter_clean_architecture_tdd/src/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:flutter_clean_architecture_tdd/src/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:flutter_clean_architecture_tdd/src/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockNumberTriviaRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockNumberTriviaLocalDataSource extends Mock
    implements NumberTriviaLocalDataSource {}

main() {
  NumberTriviaRepositoryImpl numberTriviaRepositoryImpl;
  MockNetworkInfo networkInfo;
  MockNumberTriviaLocalDataSource mockNumberTriviaLocalDataSource;
  MockNumberTriviaRemoteDataSource mockNumberTriviaRemoteDataSource;

  setUp(() {
    numberTriviaRepositoryImpl = NumberTriviaRepositoryImpl(
      localDataSource: mockNumberTriviaLocalDataSource,
      remoteDataSource: mockNumberTriviaRemoteDataSource,
      networkInfo: networkInfo
    );
  });
}
