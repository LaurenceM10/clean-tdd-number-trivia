import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_clean_architecture_tdd/src/core/network/network_info.dart';
import 'package:flutter_clean_architecture_tdd/src/core/util/input_converter.dart';
import 'package:flutter_clean_architecture_tdd/src/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:flutter_clean_architecture_tdd/src/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:flutter_clean_architecture_tdd/src/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:flutter_clean_architecture_tdd/src/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_clean_architecture_tdd/src/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_clean_architecture_tdd/src/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:flutter_clean_architecture_tdd/src/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final serviceLocator = GetIt.instance;

Future<void> init() async {
  // * Feature - Number Trivia
  // Bloc
  serviceLocator.registerFactory(
    () => NumberTriviaBloc(
      getConcreteNumberTrivia: serviceLocator(),
      getRandomNumberTrivia: serviceLocator(),
      inputConverter: serviceLocator(),
    ),
  );

  // Use cases
  serviceLocator.registerLazySingleton(
    () => GetConcreteNumberTrivia(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => GetRandomNumberTrivia(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(() => InputConverter());

  // Repositories
  serviceLocator.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      localDataSource: serviceLocator(),
      remoteDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );

  // Data Sources
  serviceLocator.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(client: serviceLocator()));
  serviceLocator.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(
      sharedPreferences: serviceLocator(),
    ),
  );

  // Core
  serviceLocator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(serviceLocator()),
  );

  // Externals
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() => http.Client());
  serviceLocator.registerLazySingleton(() => DataConnectionChecker());
}
