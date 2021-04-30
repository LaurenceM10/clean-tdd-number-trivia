part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();
  
  @override
  List<Object> get props => [];
}

class Empty extends NumberTriviaState {}

class Loading extends NumberTriviaState {}

class Error extends NumberTriviaState {
  final String message;

  Error({ @required this.message });
}
class Loaded extends NumberTriviaState {
  final NumberTrivia numberTrivia;

  Loaded({ @required this.numberTrivia });
}
