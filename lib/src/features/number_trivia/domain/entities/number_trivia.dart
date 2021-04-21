import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class NumberTrivia extends Equatable {
  final String text;
  final int number;
  final bool found;
  final String type;

  NumberTrivia({
    @required this.text,
    @required this.number,
    this.found,
    this.type,
  });

  @override
  List<Object> get props => [text, number, found, type];
}
