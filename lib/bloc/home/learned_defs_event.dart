import 'package:bag_of_words/models/definition.dart';
import 'package:equatable/equatable.dart';

abstract class LearnedDefsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LearnedDefsFetchEvent extends LearnedDefsEvent {}

class LearnedDefsAddSingleDefEvent extends LearnedDefsEvent {
  final Definition definition;
  LearnedDefsAddSingleDefEvent(this.definition);
}
