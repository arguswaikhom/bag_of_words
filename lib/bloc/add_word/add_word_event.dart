import 'package:equatable/equatable.dart';

abstract class AddWordEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddWordAddEvent extends AddWordEvent {
  final String word;
  AddWordAddEvent({required this.word});
}
