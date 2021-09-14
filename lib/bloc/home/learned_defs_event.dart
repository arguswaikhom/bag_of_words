import 'package:equatable/equatable.dart';

abstract class LearnedDefsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LearnedDefsAddWordEvent extends LearnedDefsEvent {}

class LearnedDefsFetchEvent extends LearnedDefsEvent {}
